import curves from '@ohos.curves'
import { MenuInfo} from '../model/MenuInfo'
import { getMenus, SERVER_ADDR } from '../util/DataUtil'
import router from '@ohos.router'
import http from '@ohos.net.http'

@Component
struct MenuGridItem {
  private MenuItem?: MenuInfo

  build() {
    Column() {
      Image(this.MenuItem?.image)//$r('app.media.user'))//this.MenuItem.image)//this.MenuItem!.image!)
        .objectFit(ImageFit.Contain)
        .backgroundColor('#f1f3f5')
        .width('100%')
        .height(152)
      Row() {
        Text(this.MenuItem?.name)
          .fontSize(20)

      }
      .padding({ left: 12, right: 12 })
      .width('100%')
      .height(52)
      .backgroundColor('#E5E5E5')
    }
    .height(204)
    .clip(new Rect({ width: '100%', height: '100%', radius: 12 }))

  }
}

@Component
struct MenuGrid {
  whe_openAll: boolean;
  @Link MenuItems: MenuInfo[];
  // TODO: 根据模式切换，展示不同的MenuGrid

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
    .padding({ left: 16, right: 16 })
  }
}

@Component
export default struct MenuIndex {
  @State private textInfo: string = ""
  @State MenuItems:MenuInfo[] = new Array<MenuInfo>()
  private controller: SearchController = new SearchController()
  @State whe_openAll: boolean = true
  customizeFunction: () => void = () => {
    this.MenuItems = new Array<MenuInfo>()
    let url = "http://" + SERVER_ADDR + `/menu/menus-by-input/${this.textInfo}`
    if (this.textInfo === ""){
      url = "http://" + SERVER_ADDR + `/menu/all-menu`
    }

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
  recommendFunciton: () => void = () =>{
    this.MenuItems = new Array<MenuInfo>()
    let url2 = "http://" + SERVER_ADDR + `/menu/all-menu`
    if (!this.whe_openAll){
      url2 = "http://" + SERVER_ADDR + `/menu/recommend-menu`
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
    let url = "http://" + SERVER_ADDR + `/menu/all-menu`
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
      Text('菜谱小助手')
        .fontSize(29)
        .fontColor($r("app.color.titleColor"))
        .fontWeight(FontWeight.Bold)
        .padding({ top: 15, bottom: 10, left: 25, right: 20 })
        .alignSelf(ItemAlign.Start)
        .width('100%')
        .linearGradient({
          angle: 90,
          colors: [['#FFB88C', 0.0], ["#DE6262", 0.8]]
        }).height("8%")

      Row(){
        Search({ value: this.textInfo, placeholder: '菜谱名称', controller: this.controller })
          .searchButton('Search')
          .width('75%')
          .textFont({ size: 20, weight: FontWeight.Bold })
          .placeholderFont({ size: 20, weight: FontWeight.Normal, style: FontStyle.Normal })
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .onSubmit((value: string) => {
            this.textInfo = value
            this.customizeFunction()
          })
          // .onChange((value: string) => {
          //   this.textInfo = value
          //   this.customizeFunction()
          // })

        Blank()

        Column(){
          Toggle({ type: ToggleType.Switch, isOn: true })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.whe_openAll = isOn
              this.recommendFunciton()
            })
          Row(){
            Text('推荐').fontSize(15).fontColor(this.whe_openAll ? '#DCDCDC':'#4169E1')
            Text('|').fontSize(15).fontColor('#4169E1')
            Text('全部').fontSize(15).fontColor(this.whe_openAll ? '#4169E1':'#DCDCDC')
          }.margin({right:5,bottom:5})
        }

      }.width('100%')

      MenuGrid({MenuItems : $MenuItems})
        .height("88.5%")
    }.justifyContent(FlexAlign.End)
    .padding({ bottom: 60 })
  }
}