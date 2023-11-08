import AddBtn from './Home/AddBtnComponent'
import router from '@ohos.router';
import FoodList from '../viewmodel/FoodList';
import FoodItem from '../bean/FoodItem';

@Styles function allSize() {
  .width('100%')
  .height('100%')
}
@Extend(Text) function titleTextStyle() {
  .fontSize($r('app.float.default_16'))
  .fontWeight(500)
  .width('100%')
  .fontFamily('HarmonyHeiTi_Medium')
  .fontColor($r(`app.element.color.titleColor`))
  .padding({
    top: '15%',
    bottom: '15%',
    left: '33%'
  })
}

@Component
export default struct HomeIndex {
  @Link foodList : FoodList;

  EditFoodWithPOST(){
    router.pushUrl(
      { url : 'pages/EditFoodPage',
        params:{
          foodItem : new FoodItem(null,null,null,null),
          clickAction : 'POST'
        }
      }
    )
  }

  build(){
    // Text('食物主页')
    Stack() {
      AddBtn({ clickAction: () => {this.EditFoodWithPOST()}})
      Row() {
        Text($r('app.string.EntryAbility_label'))
          .titleTextStyle()
          .fontSize($r('app.float.default_24'))
          .padding({ left: '66%' })

        // TODO: 增加默认排序/保质期排序的开关，两种选项要不直接用 toggle/switch

        // TODO: List()进行食物列表的展示，同时长按某一项时跳转至编辑页面
        // 列表单项长按时触发下面跳转
        // router.pushUrl(
        //   { url : '../pages/EditFoodPage',
        //     params:{
        //       foodItem : 某foodItem,
        //       clickAction : 'PUT'
        //     }
        //   }
        // )


      }
      .width('100%')
      .height(56)
      .position({ x: 0, y: 0 })
      .backgroundColor(`rgba(255,255,255,0)`)

    }
    .allSize()
    .backgroundColor($r('app.color.primaryBgColor'))
  }
}