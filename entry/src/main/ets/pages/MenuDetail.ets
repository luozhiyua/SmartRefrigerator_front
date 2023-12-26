import {PageTitle} from '../view/MenuComponent/PageTitle'
import {MenuImage} from '../view/MenuComponent/MenuImage'
import {IngredientList} from '../view/MenuComponent/IngredientList'
import {MenuViewModel} from '../viewModel/MenuViewModel'
import {StepList} from '../view/MenuComponent/StepList'
import thermal from '@ohos.thermal'
import { MenuInfo } from '../model/MenuInfo'
import router from '@ohos.router'
import http from '@ohos.net.http'
import { SERVER_ADDR } from '../util/DataUtil'

const SERVICE_NAME = "/nacos-discovery-provider-menu"
@Component
struct content{
  menu: MenuInfo = router.getParams()['menu']

  build(){
    Column(){
      MenuImage({ image: this.menu.image, name: this.menu.name })
      IngredientList({ ingredients: this.menu.ingredients })
      StepList({ steps: this.menu.steps })
    }
    .margin({
      top:'15%'
    })
  }
}

@Entry
@Component
struct MenuDetail {
  // @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  menu: MenuInfo = router.getParams()['menu']
  scroller: Scroller = new Scroller()
  @Provide is_collected: boolean = false
  history_collected: boolean
  private userID: string = AppStorage.Link('userID').get();

  onPageShow(){
    let httpRequest = http.createHttp();
    let url = "http://" + SERVER_ADDR + SERVICE_NAME + "/menu/collection" + `/${this.menu.id}`+`/${this.userID}`
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
      console.info(data.result.toString())
      if (data.result.toString() == "true"){
        this.is_collected = true;
      } else {
        this.is_collected = false;
      }
      this.history_collected = this.is_collected
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
  }

  build() {
    Column(){
      Stack({alignContent: Alignment.TopStart}) {
        Scroll(this.scroller) {
          Column() {
            content({menu: this.menu})
          }
          .backgroundColor('#EDF2F5')
          .align(Alignment.Top)
          .justifyContent(FlexAlign.Start)
        }
        .scrollBar(BarState.On)
        .scrollable(ScrollDirection.Vertical)
        .scrollBarColor(Color.Gray)
        .scrollBarWidth(10)
        .edgeEffect(EdgeEffect.Spring)

        Row() {
          Image($r('app.media.back'))
            .width(20)
            .height(20)
            .onClick(() => {
              if(this.history_collected != this.is_collected){
                let httpRequest = http.createHttp();
                let url = SERVER_ADDR + SERVICE_NAME + (this.is_collected ? "/menu/collect-menu" : "/menu/uncollect-menu") +`/${this.menu.id}` + `/${this.userID}`
                httpRequest.request(
                  url,
                  {
                    method: http.RequestMethod.PUT,
                    header: {
                      'Content-Type': 'application/json'
                    },
                    extraData:{
                    }
                  },(err,data)=>{
                  // 考虑弹窗提醒结果
                })
              }
              router.back({url : 'pages/Index',params : {collectChange : this.history_collected != this.is_collected}})
            })
          Text('菜谱详情')
            .fontSize(25)
            .margin({ left: 20 })
        }
        .padding(12)
        .width('100%')
        .backgroundColor('#EDF2F5')
        .height('10%')
      }
    }
  }
}