import FoodItem from '../bean/FoodItem'
import router from '@ohos.router'
import http from '@ohos.net.http';
import {getStringCategories, SERVER_ADDR} from '../util/DataUtil'

const params = router.getParams(); // 获取传递过来的参数对象
const realfoodItem = params['foodItem']
const clickAction = params['clickAction']

// function deleteFoodItem(id: number) {
//   let url="http://"+SERVER_ADDR+"/foodItem?id=id"
//   let httpRequest = http.createHttp();
//   httpRequest.request(
//     url,
//     {
//       method: http.RequestMethod.DELETE,
//     },(err,data)=>{
//     // 考虑弹窗提醒结果
//   })
//   httpRequest.destroy();
// }

@Styles
function cardStyle() {
  .backgroundColor('#EDF2F5')
  .borderRadius(12)
  .padding({ top: 8, right: 8, left: 8})
  .width('95%')
}
@Styles
function buttonStyle() {
  .borderRadius(12)
  .backgroundColor('#73CD57')
}

@CustomDialog
struct CheckDelete {
  controller: CustomDialogController
  foodItemID: number

  build() {
    Column() {
      Text('确定删除该食材吗？')
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            // TODO: DELETE 删除操作，如何参数传递
            // deleteFoodItem(this.foodItemID)
            router.back()
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

@Component
export struct FoodInfoItem{
  title: string
  value: string
  @Link newValue: string
  @Prop whe_Edit: boolean;
  private categorys: string[] = getStringCategories()

  build(){
    Column(){
      Flex({ justifyContent: FlexAlign.SpaceAround}) {
        Text(this.title+' :')
        .fontSize(20)
        if(this.whe_Edit){
          // 输入模式分为普通文本输入和文本选择(当为“种类”时)
          if(this.title == '种类'){
            Row(){
              Text(this.newValue)
                .fontColor('#708090')
                .textAlign(TextAlign.Start)
              Blank()
              Image($r('app.media.category_select'))
                .height(15)
                .width(15)
                .onClick(()=>{
                  TextPickerDialog.show({
                    range: this.categorys,
                    onAccept: (value: TextPickerResult) => {
                      this.newValue = this.categorys[value.index]
                    }
                  })
                })
            }
            .width('60%')
            .height('22%')
            .backgroundColor('#e6e6e6')
            .borderRadius(18)
            .padding(8)
          }else{
            TextInput({placeholder: this.value,text: this.newValue})
              .onChange((text: string)=>{
                this.newValue = text;
              })
              .width('60%')
          }
        }else{
          // 非输入模式只是简单展示文本内容
          Text(this.value).fontSize(20)
        }
      }
    }
  }
}


@Entry
@Component
struct FoodDetailPage {
  foodItem: FoodItem = realfoodItem
  whe_add: boolean = clickAction == 'POST'
  foodCategory: string = this.foodItem.category

  @State whe_edit: boolean = this.whe_add
  @State newName:string = ''
  @State newQuantity:string = ''
  @State newShelfLife:string = ''
  @State newAddr:string = ''
  @State newCategory:string = this.foodCategory

  // 这是用来控制 ”确认删除“弹窗的
  deleteCheckController: CustomDialogController = new CustomDialogController({
    builder: CheckDelete({foodItemID: this.foodItem.id}),
    alignment : DialogAlignment.Center
  })


  build() {
    Column() {
      if(!this.whe_edit){
        Row(){
          Image($r('app.media.return_icon'))
            .width(28)
            .height(28)
            .onClick(()=>{
              router.back()
            })
          Column().width(5)
          Text('食物详情').fontSize(25)
          Blank()
          Button('编辑',{ type: ButtonType.Normal, stateEffect: true })
            .onClick(()=>{
              this.whe_edit = true;
            })
            .buttonStyle()

          Column().width(5)

          Button('删除',{ type: ButtonType.Normal, stateEffect: true })
            .onClick(()=>{
              this.deleteCheckController.open()
            })
            .buttonStyle()
        }.width('100%')
        .margin(5)
      } else {
        Row(){
          Image($r('app.media.return_icon'))
            .width(28)
            .height(28)
            .onClick(()=>{
              router.back()
            })
          Column().width(5)
          Text('食物编辑').fontSize(25)
          Blank()
          Button('取消',{ type: ButtonType.Normal, stateEffect: true })
            .onClick(()=>{
                    if(this.whe_add)router.back()
                    else this.whe_edit = false;
                })
            .buttonStyle()

          Column().width(5)

          Button('完成',{ type: ButtonType.Normal, stateEffect: true })
            .onClick(()=>{
                    // TODO(http): 根据 whe_add 进行 PUT 或 POST
                    let httpRequest = http.createHttp();
                    if(this.whe_add){
                      httpRequest.request(
                        SERVER_ADDR+'/add-food',
                        {
                          method: http.RequestMethod.POST,
                          header: {
                            'Content-Type': 'application/json'
                          },
                          extraData:{
                            name: this.newName,
                            shelfLife: this.newShelfLife,
                            quantity: this.newQuantity,
                            category: this.newCategory,
                            addr: this.newAddr
                          }
                        },(err,data)=>{
                        // 考虑弹窗提醒结果
                      })
                    }else {
                      httpRequest.request(
                        SERVER_ADDR+'/edit-food/${this.foodItem.id}',
                        {
                          method: http.RequestMethod.PUT,
                          header: {
                            'Content-Type': 'application/json'
                          },
                          extraData:{
                            name: this.newName,
                            shelfLife: this.newShelfLife,
                            quantity: this.newQuantity,
                            category: this.newCategory,
                            addr: this.newAddr
                          }
                        },(err,data)=>{
                        // 考虑弹窗提醒结果
                      })
                    }
                    httpRequest.destroy();


                    router.back()
                  })
            .buttonStyle()
        }.width('100%')
        .margin(5)
      }

      Row()
      .height('1%')

      Row(){
        Image($r('app.media.tomato'))
        .width('40%')
        .height('50%')

        Column(){
          FoodInfoItem({title: '名字', value: this.foodItem.name,whe_Edit: this.whe_edit,newValue: $(this.newName)});
          Row().height(15)
          FoodInfoItem({title: '种类', value: this.foodCategory,whe_Edit: this.whe_edit,newValue: $(this.newCategory)});
        }
        .justifyContent(FlexAlign.Center)
        .width('55%')
      }
      .cardStyle()
      .height('20%')

      Row()
      .height('2%')

      Column(){
        FoodInfoItem({title: '食物存储量', value: this.foodItem.quantity,whe_Edit: this.whe_edit,newValue: $(this.newQuantity)});
        Divider().color('#D2D1D1')
        FoodInfoItem({title: '保质期', value: this.foodItem.shelfLife,whe_Edit: this.whe_edit,newValue: $(this.newShelfLife)});
        Divider().color('#D2D1D1')
        FoodInfoItem({title: '存放位置', value: this.foodItem.addr,whe_Edit: this.whe_edit,newValue: $(this.newAddr)});
        Divider().color('#D2D1D1')
      }
      .justifyContent(FlexAlign.SpaceAround)
      .cardStyle()
      .height('30%')

    }
    // .margin({ bottom: 5 })
    // .width('100%')
  }
}