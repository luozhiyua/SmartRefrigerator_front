import FoodItem from '../bean/FoodItem';
import { NavList, TabId } from '../model/NavItemModel';
import { SERVER_ADDR } from '../util/DataUtil';
import FoodIndex from '../view/FoodComponent';
import MenuIndex from '../view/MenuComponent';
import QAIndex from '../view/QAComponent';
import http from '@ohos.net.http';

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

  aboutToAppear(){
    console.info("IndexAppear")
    // TODO: 添加获取 foodList内容
    // TODO: 每次进入该页面都有一次远程调用，浪费资源
    let httpRequest = http.createHttp();
    let url = "http://" + SERVER_ADDR + "/food/foods-by-date"
    let promise = httpRequest.request(url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        readTimeout: 60000,
        connectTimeout: 60000
      });
    promise.then((data) => {
      const foods = JSON.parse(data.result.toString())
      for (let index = 0; index < foods.length; index++) {
        const element = foods[index];
        this.foodList.push(new FoodItem(element.id, element.name, element.freshDate, element.quantity, element.category, element.address))
      }
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
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