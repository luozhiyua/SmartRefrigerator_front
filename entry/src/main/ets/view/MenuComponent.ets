import curves from '@ohos.curves'
import { MenuInfo} from '../bean/MenuModel'
import { getMenus } from '../util/DataUtil'
import router from '@ohos.router'

@Component
struct MenuGridItem {
  private MenuItem?: MenuInfo

  build() {
    Column() {
      Image(this.MenuItem!.image!)
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
      .height(32)
      .backgroundColor('#E5E5E5')
    }
    .height(184)
    .clip(new Rect({ width: '100%', height: '100%', radius: 12 }))

  }
}

@Component
struct MenuGrid {
  whe_openAll: boolean
  private MenuItems: MenuInfo[] = getMenus()
  // TODO: 根据模式切换，展示不同的MenuGrid

  build() {
    Grid() {
      ForEach(this.MenuItems!, (item: MenuInfo) => {
        GridItem() {
          MenuGridItem({ MenuItem: item })
            .onClick(()=>{
              router.pushUrl({url:'pages/MenuDetail'})
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
  textInfo: string
  private controller: SearchController = new SearchController()
  customizeFunction: () => void = () => {}
  @State whe_openAll: boolean = true

  build() {

    Column(){
      //顶部导航栏
      Text($r('app.string.start_menu'))
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 10, bottom: 10, left: 20, right: 20 })
        .alignSelf(ItemAlign.Start)
        .width('100%')
        .backgroundColor($r('app.color.startColor'))

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
          .onChange((value: string) => {
            this.textInfo = value
            this.customizeFunction()
          })

        Blank()

        Column(){
          Toggle({ type: ToggleType.Switch, isOn: true })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.whe_openAll = isOn
            })
          Row(){
            Text('推荐').fontSize(15).fontColor(this.whe_openAll ? '#DCDCDC':'#4169E1')
            Text('|').fontSize(15).fontColor('#4169E1')
            Text('全部').fontSize(15).fontColor(this.whe_openAll ? '#4169E1':'#DCDCDC')
          }.margin({right:5,bottom:5})
        }

      }.width('100%')

      MenuGrid({whe_openAll: this.whe_openAll}).height("88.5%")

    }.justifyContent(FlexAlign.End)
  }
}