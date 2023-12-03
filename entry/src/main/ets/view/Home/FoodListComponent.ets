import FoodItem from '../../bean/FoodItem';
import router from '@ohos.router';
import { Eng2Chn, getCategoriesImage as getCategoryImage } from '../../util/DataUtil';


@Component
export struct FoodListComponent{
  // 它需改为 Link 才能与父组件同步
  @Link foodList: FoodItem[];
  foodCategory: string = ''
  private listScroller: Scroller = new Scroller();

  build(){
    Column(){
      List({space: 10,scroller: this.listScroller}){
        ForEach(this.foodCategory == ''? this.foodList : this.foodList.filter(item => (Eng2Chn(item.category) === this.foodCategory)),
          (item: FoodItem) => {
            ListItem(){
              Row(){
                Row(){
                  Image(getCategoryImage(item.category))
                    .width("100%")
                }.width("20%")

                Row().width('2%')
                //信息
                Column({ space: 4 }){
                  Row().height('0.5%')
                  Text(item.name).fontSize(25)
                    .width('40%')
                    .fontWeight(FontWeight.Bold)
                  Row().height('0.5%')
                  Row(){
                    Row(){
                      Text('数量: ').fontSize(18)
                      // .width('34%')
                      Text(item.quantity).fontSize(18)
                        // .width('60%')
                        .margin({right: '5%'})
                    }.width('30%')

                    Row(){
                      Text('保质期: ').fontSize(18)
                        // .width('33%')
                        .margin({left: '10%'})
                      Text(item.shelfLife).fontSize(18)
                        // .width('60%')
                        .margin({right: '3%'})
                    }.width('70%')
                  }.margin({bottom: 0})

                }.alignItems(HorizontalAlign.Start)
                .width('75%')
              }

              // Row(){
              //   Row(){
              //     Image(getCategoryImage(item.category))
              //       .width("80%")
              //       .margin("10%")
              //   }.width("25%")
              //
              //   //信息
              //   Column({ space: 4 }){
              //     Row()
              //       .height('0.5%')
              //     Text(item.name).fontSize(25)
              //       .width('40%')
              //       .fontWeight(FontWeight.Bold)
              //       //.margin({left: '10%' })
              //     Row()
              //       .height('0.5%')
              //     Row(){
              //     Row(){
              //       Text('数量:').fontSize(18)
              //         .width('34%')
              //       Text(item.quantity).fontSize(18)
              //         .width('60%')
              //         .margin({right: '5%'})
              //     }.width('50%')
              //
              //     Row(){
              //       Text('剩余:').fontSize(18)
              //         .width('33%')
              //         .margin({left: '10%'})
              //       Text(item.shelfLife).fontSize(18)
              //         .width('60%')
              //         .margin({right: '3%'})
              //     }.width('50%')
              //   }.margin({bottom: 0})
              //
              //   }.alignItems(HorizontalAlign.Start)
              //   .width('75%')
              // }
            }
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/FoodDetailPage',
                params: {foodItem: item}
              })
            }).borderRadius(10)
            .height('13%')
            .width("99%")
            .backgroundColor('#FFEDF2F5')

          })
      }
    }
    .width('100%')
    .height('100%')
  }

}