import curves from '@ohos.curves'
import { MenuInfo} from '../model/MenuInfo'
import { SERVER_ADDR } from '../util/DataUtil'
import router from '@ohos.router'
import http from '@ohos.net.http'
const SERVICE_NAME = "/nacos-discovery-provider-menu"
@Component
struct MenuGridItem {
  MenuItem?: MenuInfo

  build() {
    Column() {
      Image(this.MenuItem?.image)//$r('app.media.user'))//this.MenuItem.image)//this.MenuItem!.image!)
        .objectFit(ImageFit.Fill)
        .backgroundColor('#f1f3f5')
        .width('100%')
        .height('80%')
      Row() {
        Text(this.MenuItem?.name)
          .fontSize(20)
      }
      .padding({ left: 12, right: 12 })
      .width('100%')
      .height('20%')
      .backgroundColor('#E5E5E5')
    }
    .height(180)
    .clip(new Rect({ width: '100%', height: '100%', radius: 12 }))

  }
}

@Component
struct MenuGrid {
  whe_openAll: boolean;
  @Link MenuItems: MenuInfo[];

  build() {
    Grid() {
      ForEach(this.MenuItems, (item: MenuInfo) => {
        GridItem() {
          MenuGridItem({ MenuItem: item })
            .onClick(async ()=>{
              let options = {
                url: 'pages/MenuDetail',
                params: {
                  menu:item
                }
              }
              try {
                await router.pushUrl(options)
              } catch (err) {
                console.info(` fail callback, code: ${err.code}, msg: ${err.msg}`)
              }
            })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding({ left: 11, right: 11 })
  }
}

@Component
export default struct MenuIndex {
  @State private textInfo: string = ""
  @State menuShow: string = "全部菜谱";
  @State MenuItems:MenuInfo[] = new Array<MenuInfo>()
  private controller: SearchController = new SearchController()
  @State whe_openAll: boolean = true
  private userID: string = AppStorage.Link('userID').get();
  customizeFunction: () => void = () => {
    this.MenuItems = new Array<MenuInfo>()
    let url = "http://" + SERVER_ADDR + SERVICE_NAME  + `/menu/menus-by-input`
    if (this.textInfo != "") {
      let httpRequest = http.createHttp();
      let promise = httpRequest.request(url,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json'
          },
          extraData: {
            input: this.textInfo
          },
          readTimeout: 60000,
          connectTimeout: 60000
        });
      promise.then((data) => {
        const foods = JSON.parse(data.result.toString())
        console.info("读取数据库所有菜谱:" + data.result);
        for (let index = 0; index < foods.length; index++) {1
          const element = foods[index];
          this.MenuItems.push(new MenuInfo(element.menuId, element.image, element.name, element.ingredients, element.steps))
        }
      }).catch((err) => {
        console.info('error:' + JSON.stringify(err));
      });
    }
    if (this.textInfo === ""){
      url = "http://" + SERVER_ADDR + SERVICE_NAME  + `/menu/all-menu`
      let httpRequest = http.createHttp();
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
        console.info("读取数据库所有菜谱:" + data.result);
        for (let index = 0; index < foods.length; index++) {1
          const element = foods[index];
          this.MenuItems.push(new MenuInfo(element.menuId, element.image, element.name, element.ingredients, element.steps))
        }
      }).catch((err) => {
        console.info('error:' + JSON.stringify(err));
      });
    }
  }
  recommendFunciton: () => void = () =>{
    this.MenuItems = new Array<MenuInfo>()
    let url2 = "http://" + SERVER_ADDR + SERVICE_NAME  + `/menu/all-menu`
    if (!this.whe_openAll){
      url2 = "http://" + SERVER_ADDR + SERVICE_NAME  + `/menu/recommend-menu` + `/${this.userID}`
    }

    let httpRequest = http.createHttp();
    let promise = httpRequest.request(url2,
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
      console.info("读取数据库所有菜谱:" + data.result);
      for (let index = 0; index < foods.length; index++) {1
        const element = foods[index];
        this.MenuItems.push(new MenuInfo(element.menuId, element.image, element.name, element.ingredients, element.steps))
      }
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
  }


  //从数据库获得菜谱
  aboutToAppear(){
    let httpRequest = http.createHttp();
    let url = "http://" + SERVER_ADDR + SERVICE_NAME  + `/menu/all-menu`
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
      console.info("读取数据库所有菜谱:" + data.result);
      for (let index = 0; index < foods.length; index++) {
        const element = foods[index];
        this.MenuItems.push(new MenuInfo(element.menuId, element.image, element.name, element.ingredients, element.steps))
      }
      console.info(this.MenuItems[0].id.toString(),this.MenuItems[0].name.toString())
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
  }

  build() {
    Column(){
      //顶部导航栏
      Row() {
        Text('菜谱小助手')
          .fontSize(29)
          .fontColor($r("app.color.titleColor"))
          .fontWeight(FontWeight.Bold)
          .padding({ top: 15, bottom: 10, left: 25, right: 20 })
          .alignSelf(ItemAlign.Start)
          .width('60%')

        Column() {
          Image($r('app.media.ic_switch') )
            .width('20%')
            .height(25)
            .objectFit(ImageFit.Contain)
          Text(this.menuShow)
            .fontSize(13)
            .fontColor(Color.Black)
        }
        .padding({left:80,top:1})
        .onClick(() => {
                this.whe_openAll = !this.whe_openAll
                if(this.whe_openAll){
                  this.menuShow = "全部菜谱";
                }
                else{
                  this.menuShow = "推荐菜谱";
                }
                this.recommendFunciton()
              }
        )

        // Column(){
        //   Toggle({ type: ToggleType.Switch, isOn: true })
        //     .selectedColor('#007DFF')
        //     .switchPointColor('#FFFFFF')
        //     .onChange((isOn: boolean) => {
        //       this.whe_openAll = isOn
        //       this.recommendFunciton()
        //     })
        //   Row(){
        //     Text('推荐').fontSize(15).fontColor(this.whe_openAll ? '#DCDCDC':'#4169E1')
        //     Text('|').fontSize(15).fontColor('#4169E1')
        //     Text('全部').fontSize(15).fontColor(this.whe_openAll ? '#4169E1':'#DCDCDC')
        //   }.margin({right:5,bottom:5})
        // }
      }
      .height("8.7%").margin({top:0})
      .width('100%')
      .backgroundColor('#ffb366')

      Row(){
        Search({ value: this.textInfo, placeholder: '菜谱名称', controller: this.controller })
          .searchButton('搜索')
          // .width('100%')
          .textFont({ size: 20, weight: FontWeight.Bold })
          .placeholderFont({ size: 20, weight: FontWeight.Normal, style: FontStyle.Normal })
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .margin({top:14})
          .onSubmit((value: string) => {
            this.textInfo = value
            this.customizeFunction()
          })
          .onChange((value: string) => {
            if (value == ""){
              this.textInfo = value
              this.customizeFunction()
            }
          })

      }.width('90%')

      MenuGrid({MenuItems : $MenuItems})
        .height("88.5%")
        .margin({top:10})
    }.justifyContent(FlexAlign.End)
    .padding({ bottom: 60 })

    .linearGradient({
      angle: 90,
      //colors: [['#FFB88C', 0.0], ["#DE6262", 0.8]]
      colors:[['#ffb366',0.0],['#ffcc7e',0.8]]
    })
  }
}