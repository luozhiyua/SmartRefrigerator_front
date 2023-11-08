import { NavList, TabId } from '../model/NavItemModel';
import HomeIndex from '../view/HomeComponent';
import MenuIndex from '../view/MenuComponent';
import QAIndex from '../view/QAComponent';
import FoodList from '../viewmodel/FoodList';

@Styles function allSize() {
  .width('100%')
  .height('100%')
}


@Entry
@Component
struct Index {
  @State currentPage: number = 0;
  @State foodList : FoodList = new FoodList();
  private tabController: TabsController = new TabsController();

  aboutToAppear(){
    // TODO check：还是 onPageShow 呢？此处主要用来初始化食物列表
    this.foodList.initData();
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Image(index === this.currentPage ? NavList[index].icon_selected : NavList[index].icon)
        .width(25)
        .height(25)
        .objectFit(ImageFit.Contain);
      Text(NavList[index].text)
        .fontSize(15)
        .fontWeight(500)
        .fontColor(this.currentPage === index ? $r('app.color.blueColor') : $r('app.color.tabTitleColor'))
        .margin({ top: $r('app.float.default_4') })
    }.justifyContent(FlexAlign.Center).allSize()
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        HomeIndex({ foodList : $foodList })
      }
      .tabBar(this.TabBuilder(TabId.HOME))

      TabContent() {
        QAIndex()
      }
      .tabBar(this.TabBuilder(TabId.QA))

      TabContent() {
        MenuIndex()
      }
      .tabBar(this.TabBuilder(TabId.MENU))
    }
    .scrollable(false)
    .allSize()
    .barWidth('94%')
    .barMode(BarMode.Fixed)
    .vertical(false)
    .onChange((index) => {
      this.currentPage = index;
    })
  }

}