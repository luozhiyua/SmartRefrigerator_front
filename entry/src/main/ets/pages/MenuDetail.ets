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
      MenuImage({ menuId: this.menu.id, image: this.menu.image, name: this.menu.name })
      IngredientList({ ingredients: this.menu.ingredients })
      StepList({ steps: this.menu.steps })
    }
    .margin({
      top:'20%'
    })
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