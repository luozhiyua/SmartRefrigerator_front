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
          Row(){
            Text(item.name).fontSize(20)
              .width('20%')
              .height('6%')
              .margin({left: '4%'})
            // .justifyContent(FlexAlign.Start)
            Row(){
              Text('数量:').fontSize(20)
                .width('40%')
                .height('6%')
                .margin({left: '10%'})
              Text(item.quantity).fontSize(20)
                .width('50%')
                .height('6%')
                .margin({right: '3%'})
            }.width('40%')

            Row(){
              Text('剩余:').fontSize(20)
                .width('40%')
                .height('6%')
                .margin({left: '10%'})
              Text(item.shelfLife).fontSize(20)
                .width('50%')
                .height('6%')
                .margin({right: '3%'})
            }.width('40%')
          }
        }.align(Alignment.Center)

        .onClick(()=>{
          router.pushUrl({
            url: 'pages/FoodDetailPage',
            params: {foodItem: item}
          })
        }).borderRadius(10)
        .width("99%")
        .backgroundColor($r('app.color.leveBgColor'))
      })
    }
/*    .divider({
      strokeWidth: 1,
      startMargin: 0,
      endMargin: 10,
      color: $r('app.color.dividerColor')
    })*/
    .width('99%')
    .height('100%')


  }

}