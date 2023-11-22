import AddBtn from './Home/AddBtnComponent'
import router from '@ohos.router';
import FoodList from '../viewmodel/FoodList';
import FoodItem from '../bean/FoodItem';
import { getStringCategories } from '../util/DataUtil';
import { FoodListComponent } from './Home/FoodListComponent';

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
  private foodCategories: string[] = getStringCategories()


  @Builder
  tabBarItemBuilder(value: string, index: number) {
    Text(value)
      .fontColor(this.currentTabIndex === index ? 'rgba(0,0,0,0.9)' : 'rgba(0,0,0,0.6)')
      .fontSize(this.currentTabIndex === index ? 24 : 18)
      .margin({ top: 2 })
      .height(56)
      .width(60)

  }

  build() {
    Tabs() {
      TabContent() {
        FoodListComponent({ foodList: this.foodList.getData() })
      }.tabBar(this.tabBarItemBuilder("全部", 0))

      ForEach(this.foodCategories, (foodCategory: string, index?: number) => {
        TabContent() {
          FoodListComponent({ foodList: this.foodList.getData().filter(item => (item.category === foodCategory)) })
        }.tabBar(this.tabBarItemBuilder(foodCategory,
          index! + 1))
        /*.borderRadius(14)
        .backgroundColor($r('app.color.leveBgColor'))*/
      })
    }
    .animationDuration(0)
    .barWidth('100%')
    .onChange((index) => {
      this.currentTabIndex = index
    })
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
        // 使用Stack作为背景容器

        //顶部导航栏
        Text($r('app.string.start_home'))
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .padding({ top: 15, bottom: 10, left: 20, right: 20 })
          .alignSelf(ItemAlign.Start)
          .width('100%')
          .backgroundColor($r('app.color.startColor'))

        Row(){
          Row(){
            Text('排序:')
              .fontColor('#000000')
              .backgroundColor($r('app.color.white'))
              .width('20%')

            Button("名称", {type: ButtonType.Capsule , stateEffect: true})
              .borderRadius(8)
              .width('35%')
              .height("70%")
              .fontSize(16)
              .fontColor('#000000')
              .onClick(() => {
                console.log('rank change')
                console.log(this.isRankSort == false? 'flase' : 'true')
                this.isRankSort = !this.isRankSort
              })
              .borderRadius(14)
              .backgroundColor(this.isRankSort == false ? $r('app.color.notRankColor') : $r('app.color.isRankColor'))

            Button("保质期", {type: ButtonType.Normal , stateEffect: true})
              .borderRadius(8)
              .width('40%')
              .height("70%")
              .fontSize(16)
              .fontColor('#000000')
              .onClick(() => {
                console.log('rank change')
                console.log(this.isRankSort == false? 'flase' : 'true')
                this.isRankSort = !this.isRankSort
              })
              .borderRadius(14)
              .backgroundColor(this.isRankSort == false ? $r('app.color.isRankColor') : $r('app.color.notRankColor'))
              .margin({right: 0})

          }.backgroundColor($r('app.color.white'))
          .height('6%')
          .width('55%')
          .borderRadius(14)


          // Search栏
          Search({ value: this.searchInfo, placeholder: '名称', controller: this.controller })
            .searchButton('搜索')
            .width('44%')
            .height("6%")
            .textFont({ size: 20, weight: FontWeight.Bold })
            .placeholderFont({ size: 18, weight: FontWeight.Normal, style: FontStyle.Normal })
            .backgroundColor(Color.White)
            .placeholderColor(Color.Grey)
            .onSubmit((value: string) => {
              // 提交后反应
              this.searchInfo = value
              this.filter()
            })
            .onChange((value: string) => {
              this.searchInfo = value
            })
            //.margin({top : 10, bottom : 0})

        }.backgroundColor($r('app.color.leveBgColor'))
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
    .backgroundColor($r('app.color.primaryBgColor'))
  }
}