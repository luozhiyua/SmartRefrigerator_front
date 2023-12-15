import { MenuInfo } from '../model/MenuInfo'
import router from '@ohos.router'
import http from '@ohos.net.http'
import { SERVER_ADDR } from '../util/DataUtil'
import { MenuIngredient } from '../model/MenuIngredient'
@Component
struct MenuGridItem {
  private MenuItem?: MenuInfo

  build() {

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
          Column() {
            Image(item.image)//$r('app.media.user'))//this.MenuItem.image)//this.MenuItem!.image!)
              .objectFit(ImageFit.Contain)
              .backgroundColor('#f1f3f5')
              .width('100%')
              .height(152)
            Row() {
              Text(item.name)
                .fontSize(20)
            }
            .padding({ left: 12, right: 12 })
            .width('100%')
            .height(52)
            .backgroundColor('#E5E5E5')
          }
          .height(204)
          .clip(new Rect({ width: '100%', height: '100%', radius: 12 }))
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
export default struct MineIndex {
  @State MenuItems: MenuInfo[] = new Array<MenuInfo>();
  phoneNum: string = AppStorage.Link('phoneNum').get();
  userID: string = AppStorage.Link('userID').get();

  aboutToAppear(){
    let httpRequest = http.createHttp()
    let promise = httpRequest.request(
      "http://" + SERVER_ADDR + "/menu/menus-by-collect/" + `${this.userID}`,
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
      console.info("读取收藏菜谱:" + data.result);
      for (let index = 0; index < foods.length; index++) {
        const element = foods[index];
        this.MenuItems.push(new MenuInfo(element.menuId, element.image, element.name, element.ingredients, element.steps))
      }
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
  }

  build(){
    Column(){
      Column(){
        //顶部导航栏
        Row(){
          Text('我的信息')
            .fontSize(29)
            .fontWeight(FontWeight.Bold)
            .padding({ top: 15, bottom: 10, left: 25, right: 20 })
            .alignSelf(ItemAlign.Start)
        }.width('100%')
        .backgroundColor('#c0c5ff')
      }.height("8%").margin({top: 0})

      Column(){
        Row(){
          Column().width('78%')
          Button('退出',{ type: ButtonType.Normal, stateEffect: true }).onClick(()=>{
            router.replaceUrl({url: 'pages/LoginPage'})
          }).alignSelf(ItemAlign.End).borderRadius(10).backgroundColor('#0080FF')
        }.margin({top: 8})
        Column().height('12%')
        Column(){
          Image($r('app.media.user')).width(100).height(100)
          Row().height('5%')
          Text('用户：'+this.phoneNum).fontSize(22)
          // Text('账号id：'+this.userID).fontSize(18)
        }
      }.height('35%').width('100%').backgroundColor('#E0E0E0')

      Column(){
        Text('我的收藏：').fontSize(18).margin({top : 8,left : 8,bottom : 8}).alignSelf(ItemAlign.Start)
        MenuGrid({MenuItems : $MenuItems}).height('90%')
      }.height('57%').width('100%').backgroundColor('#CCE5FF')

    }.height('100%')
  }
}