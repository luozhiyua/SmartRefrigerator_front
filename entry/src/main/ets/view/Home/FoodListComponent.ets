import FoodItem from '../../bean/FoodItem';
import router from '@ohos.router';


@Component
export struct FoodListComponent{
  private foodList: Array<FoodItem>;
  private listScroller: Scroller = new Scroller();

  build(){
    List({space: 20,scroller: this.listScroller}){
      ForEach(this.foodList,(item: FoodItem) => {
        ListItem(){
          // TODO here！！！食物单项是否考虑加上小图标, 如何加,
          //  TODO here！！！单项布局再完善，还应该显示出什么信息

          Text(item.name).fontSize(20)
          .width('95%')
            .height('6%')
          .borderRadius(14)
          .backgroundColor($r('app.color.leveBgColor'))
          // .justifyContent(FlexAlign.Start)
        }.align(Alignment.Center)
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/FoodDetailPage',
            params: {foodItem: item}
          })
        })
      })
    }
    .divider({
      strokeWidth: 1,
      startMargin: 0,
      endMargin: 10,
      color: '#3f4246'
    })
    .width('100%')
    .height('100%')


  }

}