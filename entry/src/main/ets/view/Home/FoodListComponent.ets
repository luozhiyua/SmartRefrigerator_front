import FoodItem from '../../bean/FoodItem';
import router from '@ohos.router';
import { Eng2Chn, getCategoriesImage as getCategoryImage} from '../../util/DataUtil';
import systemDateTime from '@ohos.systemDateTime';


@Component
export struct FoodListComponent{
  // 它需改为 Link 才能与父组件同步
  @Link foodList: FoodItem[];
  foodCategory: string = ''
  private listScroller: Scroller = new Scroller();
  curDate : Date = new Date()

  onCreate(){
    try {
      systemDateTime.getDate((error, date) => {
        console.info(`Succeeded in getting date : ${date}`);
        this.curDate = date
      });
    } catch(e) {
      console.info(`Failed to get date. message:${e.message}, code:${e.code}`);
    }
  }

  judge_urgent(freshDate: string){
    let ddl = new Date(freshDate); // 2024-1-1;2023-12-31
    let timeDifference = ddl.getTime() - this.curDate.getTime();
    return Math.floor(timeDifference / (1000 * 3600 * 24));
  }

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
                }.width("25%")

                Row().width('5%')
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
                      Text(item.quantity).fontSize(18)
                        .margin({right: '5%'})
                    }.width('30%')
                    Row().width('15%')
                    Row(){
                      if(this.judge_urgent(item.shelfLife) < 0){
                        Text('已过期').fontSize(22).fontColor('#FF0000').fontWeight(FontWeight.Bold)
                      }else {
                        Text('剩余'+this.judge_urgent(item.shelfLife)+'天').fontSize(this.judge_urgent(item.shelfLife) <= 3 ? 20 : 18)
                          .fontColor(this.judge_urgent(item.shelfLife) <= 3 ? '#FF4500':'#000000')
                      }
                    }.width('50%').margin({left: '5%'})
                  }.margin({bottom: 0})

                }.alignItems(HorizontalAlign.Start)
                .width('75%')
              }
              .margin({left: 10,right: 10})
            }
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/FoodDetailPage',
                params: {foodItem: item}
              })
            }).borderRadius(10)
            .height('15%')
            .width("99%")
            .backgroundColor('#F4F9F9')
          })
      }
      .width('100%').height('100%')
    }
    .width('100%')
    .height('100%')
  }

}