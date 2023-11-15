import curves from '@ohos.curves'
import { MenuInfo} from '../bean/MenuModel'
import { getMenus } from '../util/DataUtil'

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
  private MenuItems: MenuInfo[] = getMenus()

  build() {
    Grid() {
      ForEach(this.MenuItems!, (item: MenuInfo) => {
        GridItem() {
          MenuGridItem({ MenuItem: item })
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

  build() {

    Column(){
      Search({ value: this.textInfo, placeholder: '菜谱名称', controller: this.controller })
        .searchButton('Search')
        .width('75%')
        .height("10%")
        .textFont({ size: 25, weight: FontWeight.Bold })
        .placeholderFont({ size: 25, weight: FontWeight.Normal, style: FontStyle.Normal })
        .backgroundColor(Color.White)
        .placeholderColor(Color.Grey)
        .onSubmit((value: string) => {
          this.textInfo = value
          this.customizeFunction()
        })
        .onChange((value: string) => {
          this.textInfo = value
          this.customizeFunction()
        })
        .margin({top : 10, bottom : 0, left : 30})

      MenuGrid().height("89%")

    }.justifyContent(FlexAlign.End)
  }
}