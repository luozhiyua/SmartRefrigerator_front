import FoodItem from '../bean/FoodItem'
import router from '@ohos.router'
import http from '@ohos.net.http';
import {getChineseCategories, getCategoriesImage, getFoodInfokey, SERVER_ADDR, getEnglishCategories, Eng2Chn, showToastContent} from '../util/DataUtil'

const params = router.getParams(); // 获取传递过来的参数对象
const realfoodItem = params['foodItem']
const clickAction = params['clickAction']
const SERVICE_NAME = "/nacos-discovery-provider-food"

async function deleteFoodItem(id: number) {
  let httpRequest = http.createHttp();
  httpRequest.request(
    // SERVER_ADDR+"/food/delete-food/"+`${id}`,
    SERVER_ADDR + SERVICE_NAME + "/food/delete-food/"+`${id}`,
    {
      method: http.RequestMethod.DELETE,
    },(err,data)=>{
    // 考虑弹窗提醒结果
  })
  httpRequest.destroy();
}

@Styles
function cardStyle() {
//  .backgroundColor('#F4F9F9')
  .backgroundColor("#fff5f6")
  .borderRadius(12)
  .padding({ top: 8, right: 8, left: 8})
  .width('95%')
}

@Styles
function selectRowStyle() {
  .width('60%')
  .height('25%')
  .backgroundColor('#e6e6e6')
  .borderRadius(18)
  .padding(8)
}

function dealDate(value: number){
  if(value < 10)return '0'+value
  return value.toString()
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
          .onClick(async () => {
            await deleteFoodItem(this.foodItemID)
            router.replaceUrl({url: "pages/Index",params : {collectChange :false}})
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
  @State newValue: string = ''
  @Consume new_foodItem: FoodItem
  @Consume @Watch('edit_change') whe_edit: boolean;
  private ChiCategories: string[] = getChineseCategories()
  private cate_eng: string[] = getEnglishCategories()

  edit_change(){
    if(this.title == '种类')this.newValue = Eng2Chn(this.value);
    else this.newValue = this.value;
  }

  build(){
    Column(){
      // Flex({ justifyContent: FlexAlign.SpaceAround}) {
      Row(){
        Text(this.title+' :  ')
        .fontSize(24)
          .margin({left: 7})
        Blank()
        if(this.whe_edit){
          // 输入模式分为普通文本输入和文本选择(当为“种类”时)
          if(this.title == '种类'){
            Row(){
              Text(this.new_foodItem.category == this.value ? Eng2Chn(this.value) : this.newValue)
                .fontColor('#708090')
                .textAlign(TextAlign.Start)
              Blank()
              Image($r('app.media.category_select'))
                .height(20)
                .width(20)
            }
            .onClick(()=>{
              TextPickerDialog.show({
                range: this.ChiCategories,
                onAccept: (value: TextPickerResult) => {
                  this.newValue = this.ChiCategories[value.index]
                  this.new_foodItem.category = this.cate_eng[value.index]
                }
              })
            })
            .selectRowStyle()
          }
          else if(this.title == '保质期'){
            Row(){
              Text(this.new_foodItem.shelfLife == this.value ? this.value : this.newValue)
                .fontColor('#708090')
                .textAlign(TextAlign.Start)
              Blank()
              Image($r('app.media.category_select'))
                .height(20)
                .width(20)
            }
            .onClick(()=>{
              DatePickerDialog.show({
                start: new Date('2023-12-1'),
                end: new Date('2100-1-1'),
                onAccept: (value: DatePickerResult) => {
                  this.newValue = value.year + '-' + dealDate(value.month+1) + '-' + dealDate(value.day)
                  this.new_foodItem.shelfLife = this.newValue
                }
              })
            })
            .selectRowStyle()
          } else{
            TextInput({placeholder: this.value,text: this.newValue})
              .onChange((text: string)=>{
                this.newValue = text;
                this.new_foodItem[getFoodInfokey(this.title)] = text;
              })
              .width('60%')
          }
        }else{
          // 非输入模式只是简单展示文本内容
          if(this.title == '种类') {
            Text(Eng2Chn(this.value)).fontSize(24)
          } else {
            Text(this.value).fontSize(24)
          }
        }
      }
      .margin(5)
    }
  }
}

@Component
struct FirstLine{
  headText: string
  leftText: string
  rightText: string
  LeftFunction: Function = () => {};
  RightFunction: Function = () => {};

  @Builder buttonUse(buttonText,onClickFunction){
    Button(buttonText,{ type: ButtonType.Normal, stateEffect: true })
      .onClick(onClickFunction)
      .borderRadius(13)
      .fontColor('#000000')
      .fontSize(20)
      .backgroundColor('#fff5f6')
  }

  build(){
    Row(){
      Column().width(7)
      Image($r('app.media.back'))
        .width(35)
        .height(35)
        .onClick(()=>{
          router.replaceUrl({url : 'pages/Index',params : {collectChange : false}})
        })
      Column().width(3)
      Text(this.headText).fontSize(29)
      Blank()
      this.buttonUse(this.leftText,this.LeftFunction)
      Column().width(5)
      this.buttonUse(this.rightText,this.RightFunction)
    }.width('100%')
    .margin({ top: 0 })
    .height("8%")
    .backgroundColor("#ee9ca7")
  }
}

@Entry
@Component
struct FoodDetailPage {
  foodItem: FoodItem = realfoodItem
  whe_add: boolean = clickAction == 'POST'
  private userID: string = AppStorage.Link('userID').get();

  @Provide whe_edit: boolean = this.whe_add
  @Provide new_foodItem: FoodItem = new FoodItem(this.foodItem.id,this.foodItem.name,
    this.foodItem.shelfLife,this.foodItem.quantity,this.foodItem.category,this.foodItem.addr)

  // 这是用来控制 ”确认删除“弹窗的
  deleteCheckController: CustomDialogController = new CustomDialogController({
    builder: CheckDelete({foodItemID: this.foodItem.id}),
    alignment : DialogAlignment.Center
  })

  submit() {
    // 验证每个字段是否为空
    if (this.new_foodItem.name === '' || this.new_foodItem.category === '' || this.new_foodItem.quantity === '' || this.new_foodItem.shelfLife === '' || this.new_foodItem.addr === '') {
      // 如果有任何字段为空，弹出警告
      AlertDialog.show({
        title: '警告',
        message: '请填写所有必填字段。',
      });
    }else{
      let httpRequest = http.createHttp();
      if(this.whe_add){
        httpRequest.request(
          SERVER_ADDR+SERVICE_NAME+'/food/add-food',
          {
            method: http.RequestMethod.POST,
            header: {
              'Content-Type': 'application/json'
            },
            extraData:{
              name: this.new_foodItem.name,
              userId: this.userID,
              freshDate: this.new_foodItem.shelfLife,
              quantity: this.new_foodItem.quantity,
              category: this.new_foodItem.category,
              address: this.new_foodItem.addr
            }
          },(err,data)=>{
        })
      }else {
        httpRequest.request(
          SERVER_ADDR+SERVICE_NAME+"/food/edit-food/"+`${this.new_foodItem.id}`,
          {
            method: http.RequestMethod.PUT,
            header: {
              'Content-Type': 'application/json'
            },
            extraData:{
              name: this.new_foodItem.name,
              userId: this.userID,
              freshDate: this.new_foodItem.shelfLife,
              quantity: this.new_foodItem.quantity,
              category: this.new_foodItem.category,
              address: this.new_foodItem.addr
            }
          },(err,data)=>{
          // 考虑弹窗提醒结果
        })
      }
      httpRequest.destroy();
      showToastContent('提交成功！')
      // 能否等 1s再切换
      setTimeout(function() {
        router.replaceUrl({url: "pages/Index",params : {collectChange :false}});
      }, 500);
    }
}

  build() {
    Column(){
      Column() {
        if(!this.whe_edit){
          FirstLine({headText:'食物详情',leftText:'编辑',rightText:'删除',
            LeftFunction:()=>{
              this.whe_edit = true
              this.whe_add = false
            },
            RightFunction:()=>{this.deleteCheckController.open()}})
        } else {
          FirstLine({headText:'食物编辑',leftText:'取消',rightText:'完成',
            LeftFunction:()=>{
              if(this.whe_add)router.back()
              else {
                this.new_foodItem = new FoodItem(this.foodItem.id,this.foodItem.name,
                  this.foodItem.shelfLife,this.foodItem.quantity,this.foodItem.category,this.foodItem.addr)
                this.whe_edit = false;
              }
            },
            RightFunction:()=>{ this.submit();}})
        }

        Row().height('2%')

        Row(){
          Column().width(5)
          Image(getCategoriesImage(this.new_foodItem.category))
            .width(120)
            .height(120)

          Column(){
            FoodInfoItem({title: '名字', value: this.foodItem.name});
            Row().height(15)
            FoodInfoItem({title: '种类', value: this.foodItem.category});
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .width('55%')
        }
        .cardStyle()
        .height('19%')

        Row().height('2%')

        Column(){
          FoodInfoItem({title: '食物存量', value: this.foodItem.quantity});
          Divider().color('#D2D1D1')
          FoodInfoItem({title: '保质期', value: this.foodItem.shelfLife});
          Divider().color('#D2D1D1')
          FoodInfoItem({title: '存放位置', value: this.foodItem.addr});
          Divider().color('#D2D1D1')
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceAround)
        .cardStyle()
        .height('30%')

      }
    }.height("100%")
    .linearGradient({
      angle: 90,
      colors: [['#ee9ca7', 0.0], ["#fbc7d4", 0.7]]
    })

    // .margin({ bottom: 5 })
    // .width('100%')
  }
}