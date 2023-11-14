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

  // TODO: 从人机角度，单项后面最好有叉以取消单项编辑
  // TODO here！！！ 页面 UI调整

  build(){
    Column(){
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Text(this.title)
        if(this.whe_Edit){
          // 输入模式分为普通文本输入和文本选择(当为“种类”时)
          if(this.title == '种类'){
            // TODO here！！！ “种类” 中间文本样式调整
            Text(this.newValue)
            Button('选择').onClick(()=>{
              TextPickerDialog.show({
                range: this.categorys,
                onAccept: (value: TextPickerResult) => {
                  this.newValue = this.categorys[value.index]
                }
              })
            })
          }else{
            TextInput({placeholder: this.value,text: this.newValue})
              .onChange((text: string)=>{
                this.newValue = text;
              })
          }
        }else{
          // 非输入模式只是简单展示文本内容
          Text(this.value)
        }
      }
      Divider()
        .color('#3f4246')
    }
  }
}


@Entry
@Component
struct FoodDetailPage {
  // TODO: 这里不能直接 params['foodItem'] 赋值，否则会错。奇怪。
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

  // TODO here！！！页面布局怎样调整，包括字体大小等...

  build() {
    Column() {
      if(!this.whe_edit){
        Row(){
          // TODO here！！！ 增加返回键，返回上一个页面
          Button('编辑')
            .onClick(()=>{
              this.whe_edit = true;
            })
          Button('删除')
            .onClick(()=>{
              this.deleteCheckController.open()
            })
        }
      }

      FoodInfoItem({title: '名字', value: this.foodItem.name,whe_Edit: this.whe_edit,newValue: $newName});
      FoodInfoItem({title: '存量', value: this.foodItem.quantity,whe_Edit: this.whe_edit,newValue: $newQuantity});
      FoodInfoItem({title: '保质期', value: this.foodItem.shelfLife,whe_Edit: this.whe_edit,newValue: $newShelfLife});
      FoodInfoItem({title: '位置', value: this.foodItem.addr,whe_Edit: this.whe_edit,newValue: $newAddr});
      FoodInfoItem({title: '种类', value: this.foodCategory,whe_Edit: this.whe_edit,newValue: $newCategory});

      if(this.whe_edit){
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Button('取消')
            .onClick(()=>{
              if(this.whe_add)router.back()
              else this.whe_edit = false;
            })

          Button('完成')
            .onClick(()=>{
              // TODO: 根据 whe_add 进行 PUT 或 POST
              // let httpRequest = http.createHttp();
              // if(this.whe_add){
              //   httpRequest.request(
              //     SERVER_ADDR+'/foodItem',
              //     {
              //       method: http.RequestMethod.POST,
              //       header: {
              //         'Content-Type': 'application/json'
              //       },
              //       extraData:{
              //         name: this.newName,
              //         shelfLife: this.newShelfLife,
              //         quantity: this.newQuantity,
              //         category: this.newCategory,
              //         addr: this.newAddr
              //       }
              //     },(err,data)=>{
              //     // 考虑弹窗提醒结果
              //   })
              // }else {
              //   httpRequest.request(
              //     SERVER_ADDR+'/foodItem/${this.foodItem.id}',
              //     {
              //       method: http.RequestMethod.PUT,
              //       header: {
              //         'Content-Type': 'application/json'
              //       },
              //       extraData:{
              //         name: this.newName,
              //         shelfLife: this.newShelfLife,
              //         quantity: this.newQuantity,
              //         category: this.newCategory,
              //         addr: this.newAddr
              //       }
              //     },(err,data)=>{
              //     // 考虑弹窗提醒结果
              //   })
              // }
              // httpRequest.destroy();


              router.back()
            })
        }
      }
    }
    .margin({ bottom: 5 })
    .width('100%')
    .borderStyle(BorderStyle.Solid)
  }
}