import FoodItem from '../bean/FoodItem';
import { NavList, TabId } from '../model/NavItemModel';
import FoodIndex from '../view/FoodComponent';
import MenuIndex from '../view/MenuComponent';
import QAIndex from '../view/QAComponent';

@Styles function allSize() {
  .width('100%')
  .height('100%')
}


@Entry
@Component
struct Index {
  @State currentPage: number = 0;
  private tabController: TabsController = new TabsController();

  @State foodList : FoodItem[] = new Array<FoodItem>();

  onPageShow(){
    // TODO: 添加获取 foodList内容
    // TODO: 每次进入该页面都有一次远程调用，浪费资源
    this.foodList.push(new FoodItem(4,"苹果","3天","10个","水果","冷藏1层"));
    this.foodList.push(new FoodItem(5,"白菜","3天","10个","蔬菜","冷藏1层"));
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
        FoodIndex({ foodList : $foodList })
        // FoodIndex()
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