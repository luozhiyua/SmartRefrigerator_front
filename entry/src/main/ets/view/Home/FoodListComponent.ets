import FoodItem from '../../bean/FoodItem';
import router from '@ohos.router';
import { getEnglishCategories } from '../../util/DataUtil';


@Component
export struct FoodListComponent{
  private foodList: Array<FoodItem>;
  private listScroller: Scroller = new Scroller();
  private image_type: Resource ;
  private test: Resource = $r('app.media.fruit');


  build(){
    List({space: 10,scroller: this.listScroller}){
      ForEach(this.foodList,(item: FoodItem) => {
        ListItem(){
          // TODO here！！！食物单项是否考虑加上小图标, 如何加,
          //  TODO here！！！单项布局再完善，还应该显示出什么信息

          Row(){
            //图片
            Row(){
              Image(getEnglishCategories(item.category))
                .width("80%")
                .margin("10%")

              //console.toString( this.image_type )
              //Image(this.test)

            }.width("25%")

            //信息
            Column({ space: 4 }){
              Row()
                .height('0.5%')
              Text(item.name).fontSize(25)
                .width('40%')
                .fontWeight(FontWeight.Bold)
                //.margin({left: '10%' })
              Row()
                .height('0.5%')
              Row(){
              Row(){
                Text('数量:').fontSize(18)
                  .width('34%')
                Text(item.quantity).fontSize(18)
                  .width('60%')
                  .margin({right: '5%'})
              }.width('40%')

              Row(){
                Text('剩余:').fontSize(18)
                  .width('33%')
                  .margin({left: '10%'})
                Text(item.shelfLife).fontSize(18)
                  .width('60%')
                  .margin({right: '3%'})
              }.width('40%')
            }.margin({bottom: 0})

            }.alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          }

        .onClick(()=>{
          router.pushUrl({
            url: 'pages/FoodDetailPage',
            params: {foodItem: item}
          })
        }).borderRadius(10)
        .width("99%")
        .backgroundColor('#FFEDF2F5')

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