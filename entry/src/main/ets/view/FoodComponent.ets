import AddBtn from './Home/AddBtnComponent'
import router from '@ohos.router';
import FoodList from '../viewmodel/FoodList';
import FoodItem from '../bean/FoodItem';
import { getChineseCategories, getEnglishCategories } from '../util/DataUtil';
import { FoodListComponent } from './Home/FoodListComponent';
import { SortMenuComponent } from './Home/sortType/SortMenuComponent';
import { SelectExample } from './Home/sortType/selectSortType';
import { popupSortType } from './Home/sortType/popupSortType';
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
export struct CategoryModeFoods {
  @State currentTabIndex: number = 0
  private foodList: FoodList;
  private foodCategories: string[] = getChineseCategories()
  //private imageCategories: ResourceStr[] = getEnglishCategories()
  /*imageCategories: Resource[] =
[$r('app.media.vegetable'),$r("app.media.fruit"),
  $r("app.media.meals"), $r('app.media.seafood'),
  $r('app.media.snacks'),$r('app.media.others')]*/

  @Builder
  tabBarItemBuilder(value: string, index: number) {
    Text(value)
      .fontColor(this.currentTabIndex === index ? 'rgba(0,0,0,0.9)' : 'rgba(0,0,0,0.6)')
      .fontSize(this.currentTabIndex === index ? 23 : 17)
      .margin({ top: 2 })
      .height(56)
      .width("98%")

  }

  build() {

    Tabs() {
      TabContent() {
        FoodListComponent({ foodList: this.foodList.getData() })
      }.tabBar(this.tabBarItemBuilder("全部", 0))

      ForEach(this.foodCategories, (foodCategory: string, index?: number) => {
        TabContent() {
          FoodListComponent({ foodList: this.foodList.getData().filter(item => (item.category === foodCategory)),
          })
        }.tabBar(this.tabBarItemBuilder(foodCategory,
          index ! + 1))


        /*.borderRadius(14)
        .backgroundColor($r('app.color.leveBgColor'))*/
      })
    }
    .animationDuration(0)
    .barWidth('100%')
    .onChange((index) => {
      this.currentTabIndex = index
    })
    .width('95%')

  }

}

@Component
export struct FreshDateFoods{
  // TODO: 按保质期排序，前端处理的话在这里处理；后端处理的话，这里 foodList 就应该是远程获取的结果
  private foodList: FoodList;
  build(){
    FoodListComponent({ foodList: this.foodList.getData()})
  }
}


@Component
export default struct FoodIndex {
  @Link foodList : FoodList;
  @State sortByFresh: boolean = false;

  @State searchInfo: string = '';
  private controller: SearchController = new SearchController()
  private isRankSort: Boolean = false;
  // TODO: 搜索功能实现
  filter: () => void = () => {}
  // filter: () => {
  //
  // }


  EditFoodWithPOST(){
    router.pushUrl(
      { url : 'pages/FoodDetailPage',
        params:{
          // TODO: 这里的 null 可能导致出错
          foodItem : new FoodItem(null,'','','','',''),
          clickAction : 'POST'
        }
      }
    )
  }

  build(){ // Text('食物主页')
    Stack() {
      Column(){
        //顶部导航栏
        Row(){
          Text('食材小管家')
            .fontSize(29)
            .fontColor($r("app.color.titleColor"))
            .fontWeight(FontWeight.Bold)
            .padding({ top: 15, bottom: 10, left: 25, right: 20 })
            .alignSelf(ItemAlign.Start)
            .width('80%')
          //排序方式
         /* 以菜单方式
          SortMenuComponent()*/
          /*以下拉选择菜单
          SelectExample()*/
          popupSortType()
        }.backgroundColor('#ee9ca7')
        /*.linearGradient({
          angle: 90,
          colors: [['#ee9ca7', 0.0], ["#fbc7d4", 0.7]]
        })*/
        .height("8%")

          // Search栏
          Search({ value: this.searchInfo, placeholder: '名称', controller: this.controller })
            .searchButton('搜索')
            .width('90%')
            .height("6%")
            .textFont({ size: 20, weight: FontWeight.Bold })
            .placeholderFont({ size: 18, weight: FontWeight.Normal, style: FontStyle.Normal })
            .backgroundColor('#FFEDF2F5')
            .placeholderColor(Color.Gray)
            .onSubmit((value: string) => {
              // 提交后反应
              this.searchInfo = value
              this.filter()

            })
            .onChange((value: string) => {
              this.searchInfo = value
            })
          //.margin({top : 10, bottom : 0})

        // Row(){
        //   Text("食物列表")
        //   // 默认 false 为按品类排序，一旦isOn,则触发按保质期排序
        //   // TODO: 位置是否改成between分布？如何提醒用户toggle的作用
        //   Toggle({type: ToggleType.Switch, isOn: false})
        //     .onChange((isOn: boolean) => {
        //       this.sortByFresh = isOn;
        //     })
        // }

        // 食物列表
        if(this.isRankSort){
          FreshDateFoods({foodList: this.foodList})
        }else {
          CategoryModeFoods({foodList: this.foodList})
        }
      }
      // ”添加“按钮
      AddBtn({ clickAction: () => {this.EditFoodWithPOST()}})
    }
    .allSize()
    //.backgroundColor($r('app.color.white'))
    .linearGradient({
      angle: 90,
      colors: [['#ee9ca7', 0.0], ["#fbc7d4", 0.7]]
    })
  }
}