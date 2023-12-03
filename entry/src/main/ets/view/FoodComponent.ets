import AddBtn from './Home/AddBtnComponent'
import router from '@ohos.router';
import FoodItem from '../bean/FoodItem';
import { getChineseCategories, SERVER_ADDR} from '../util/DataUtil';
import { FoodListComponent } from './Home/FoodListComponent';
import { SortMenuComponent } from './Home/sortType/SortMenuComponent';
import http from '@ohos.net.http';
@Styles function allSize() {
  .width('100%')
  .height('100%')
}

@Component
export struct CategoryModeFoods {
  @State currentTabIndex: number = 0
  @Link foodList: FoodItem[];
  foodCategories: string[] = getChineseCategories()

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
        FoodListComponent({ foodList: $foodList})
      }.tabBar(this.tabBarItemBuilder("全部", 0))

      ForEach(this.foodCategories, (foodCategory: string, index?: number) => {
        TabContent() {
          FoodListComponent({ foodList: $foodList,foodCategory: foodCategory})
        }.tabBar(this.tabBarItemBuilder(foodCategory,
          index ! + 1))
      })
    }
    .animationDuration(0)
    .barWidth('100%')
    .onChange((index) => {
      this.currentTabIndex = index
    })
    .width('96%')

  }

}

@Component
export default struct FoodIndex {
  @Link foodList : FoodItem[]
  @State @Watch('onSortWayChange') selectByName: boolean = false

  @State searchInfo: string = '';
  private controller: SearchController = new SearchController()

  onSortWayChange(){
    if(this.selectByName) {
      let httpRequest = http.createHttp();
      let url = "http://" + SERVER_ADDR + "/food/foods-by-name"
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
        this.foodList = new Array<FoodItem>()
        for (let index = 0; index < foods.length; index++) {
          const element = foods[index];
          this.foodList.push(new FoodItem(element.id, element.name, element.freshDate, element.quantity, element.category, element.address))
        }
      }).catch((err) => {
        console.info('error:' + JSON.stringify(err));
      });
    } else {
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
        this.foodList = new Array<FoodItem>()
        for (let index = 0; index < foods.length; index++) {
          const element = foods[index];
          this.foodList.push(new FoodItem(element.id, element.name, element.freshDate, element.quantity, element.category, element.address))
        }
      }).catch((err) => {
        console.info('error:' + JSON.stringify(err));
      });
    }
  }

  EditFoodWithPOST(){
    router.pushUrl(
      { url : 'pages/FoodDetailPage',
        params:{
          foodItem : new FoodItem(-1,'','','','',''),
          clickAction : 'POST'
        }
      }
    )
  }

  build(){
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

          // 其余方式: SelectExample()  popupSortType()
          SortMenuComponent({selectByName : $selectByName})

        }.backgroundColor('#ee9ca7')
        .height("8%")

          // Search栏
          Search({ value: this.searchInfo, placeholder: '请输入名称', controller: this.controller })
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
              // 搜索功能
              let httpRequest = http.createHttp();
              let url = "http://" + SERVER_ADDR + "/food/foods-by-input/"+`${this.searchInfo}`
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
                  this.foodList = new Array<FoodItem>()
                  this.foodList.push(new FoodItem(element.id, element.name, element.freshDate, element.quantity, element.category, element.address))
                }
              }).catch((err) => {
                console.info('error:' + JSON.stringify(err));
              });
            })
            .onChange((value: string) => {
              this.searchInfo = value
              if (this.searchInfo == ""){
                router.replaceUrl({url: "pages/Index"})
              }
            })

        // 食物列表
        CategoryModeFoods({foodList: $foodList}).height('82%')
      }
      // ”添加“按钮
      AddBtn({ clickAction: () => {this.EditFoodWithPOST()}})
    }
    .allSize()
    .linearGradient({
      angle: 90,
      colors: [['#ee9ca7', 0.0], ["#fbc7d4", 0.7]]
    })
  }
}