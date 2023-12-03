import {PageTitle} from '../view/MenuComponent/PageTitle'
import {MenuImage} from '../view/MenuComponent/MenuImage'
import {IngredientList} from '../view/MenuComponent/IngredientList'
import {MenuViewModel} from '../viewModel/MenuViewModel'
import {StepList} from '../view/MenuComponent/StepList'
import thermal from '@ohos.thermal'
import { MenuInfo } from '../model/MenuInfo'
import router from '@ohos.router'

@Component
struct content{
  private menu: MenuInfo = router.getParams()['menu']

  build(){
    Column(){
      MenuImage({ image: $r('app.media.strawberry'), name: this.menu.name })
      IngredientList({ ingredients: this.menu.ingredients })
      StepList({ steps: this.menu.steps })
    }
    .margin({
      top:'20%'
    })
  }
}


@Component
struct MenuTitle {
  private title: string | Resource | undefined = '';
  private subtitle: string | Resource | undefined = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(26)
      Blank()
      Text(this.subtitle)
        .fontSize(13)
        .fontColor('rgba(0,0,0,0.6)')
    }
    .width('100%')
    .height(26)
  }
}



@Entry
@Component
struct MenuDetail {
  // @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  private menu: MenuInfo;
  scroller: Scroller = new Scroller()

  build() {

    Column(){

      Stack({alignContent: Alignment.TopStart}) {
        Scroll(this.scroller) {
          Column() {
            content({menu: this.menu})
          }
          .backgroundColor('#EDF2F5')
          //.height('100%')
          .align(Alignment.Top)
          .justifyContent(FlexAlign.Start)
        }
        .scrollBar(BarState.On)
        .scrollable(ScrollDirection.Vertical)
        .scrollBarColor(Color.Gray)
        .scrollBarWidth(10)
        .edgeEffect(EdgeEffect.Spring)

        PageTitle()
      }
    }
  }
}