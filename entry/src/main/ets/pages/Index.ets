import FoodItem from '../bean/FoodItem';
import { NavList, TabId } from '../model/NavItemModel';
import { SERVER_ADDR } from '../util/DataUtil';
import FoodIndex from '../view/FoodComponent';
import MenuIndex from '../view/MenuComponent';
import QAIndex from '../view/QAComponent';
import http from '@ohos.net.http';
import MineIndex from '../view/MineComponent';
import { MenuInfo } from '../bean/MenuModel';
import router from '@ohos.router';

const SERVICE_NAME = "/nacos-discovery-provider-food"

@Styles function allSize() {
  .width('100%')
  .height('100%')
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0;
  private tabController: TabsController = new TabsController();
  private userID: string = AppStorage.Link('userID').get();
  @State foodList : FoodItem[] = new Array<FoodItem>();
  @Provide collect_change: boolean = false

  onPageShow() {
    const params = router.getParams(); // 获取传递过来的参数对象
    const collectChange = params['collectChange']; // 将属性值存储在临时变量中
    if(collectChange){
      this.collect_change = !this.collect_change;
    }
  }

  aboutToAppear(){
    // console.info("IndexAppear")
    // this.foodList.push(new FoodItem(0,'苹果','2024-01-01','2个','FRUIT','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2023-12-01','2个','VEGETABLE','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2023-12-11','2个','MEAT','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2023-12-13','2个','SEAFOOD','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2023-12-15','2个','SNACK','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2023-12-18','2个','OTHER','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2024-01-01','2个','FRUIT','2层'))
    // this.foodList.push(new FoodItem(0,'苹果','2024-01-05','2个','FRUIT','2层'))

    let httpRequest = http.createHttp();
    let url = "http://" + SERVER_ADDR + SERVICE_NAME + "/food/foods-by-date" + `/${this.userID}`
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
    httpRequest.destroy();
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Image(index === this.currentPage ? NavList[index].icon_selected : NavList[index].icon)
        .width(25)
        .height(25)
        .objectFit(ImageFit.Contain);
      Text(NavList[index].text)
        .fontSize(15.5)
        .fontWeight(500)
        .fontColor(this.currentPage === index ? Color.Black : $r('app.color.tabTitleColor'))
        .margin({ top: $r('app.float.default_4') })
    }.justifyContent(FlexAlign.Center).allSize()

  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        FoodIndex({ foodList : $foodList })
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

      TabContent(){
        MineIndex()
      }.tabBar(this.TabBuilder(TabId.MINE))
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