import ChefRes from './QA/ChefRes'
import ChefTitle from './QA/ChefTitle'
import { UserRes } from './QA/UserRes'
@Extend(Line)
function lineStyle() {
  .width('100%')
  .height("1vp")
  .backgroundColor("#df73ff")
}

@Component
export default struct QAIndex {
  @State text: string[] = [""]
  @State textNow: string = ""
  @State textLength: number = 1
  alignContent: number = 0
  controller: TextInputController = new TextInputController()
  scroller: Scroller = new Scroller()

  build() {
    Column() {
      //顶部导航栏
      Text($r('app.string.start_qa'))
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 15, bottom: 10, left: 20, right: 20 })
        .alignSelf(ItemAlign.Start)
        .width('100%')
        .backgroundColor($r('app.color.startColor'))

      ChefTitle()
      Line().lineStyle()

      Scroll(this.scroller) {
        Column() { //未来改成scroll
          ForEach(this.text, (item, index) => {
            ChefRes()

            if (index == this.textLength - 1) {
              UserRes({item: this.textNow})
            } else {
              UserRes({item: item})
            }
          })
        }
      }
      .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
      .scrollBar(BarState.On)  // 滚动条常驻显示
      .scrollBarColor(Color.Gray)  // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .onScroll((xOffset: number, yOffset: number) => {
        console.info(xOffset + ' ' + yOffset)
      })
      .onScrollEdge((side: Edge) => {
        console.info('To the edge')
      })

      Row() {
        TextInput({ placeholder: 'inline style', controller: this.controller })
          .width("60%")
          .height(60)
          .margin(20)
          .fontSize(18)
          .borderRadius(0)
          .style(TextInputStyle.Inline)
          .onChange((value: string) => {
            this.textNow = value
          })
        Button('发送')
          .margin(15)
          .onClick(() => {
            this.text[this.textLength - 1] = this.textNow;
            this.text[this.textLength] = ""
            this.textNow = "";
            this.textLength++
          })
      }
      .margin({
        bottom: "3%"
      })

      Text("目前对话：chatGLM")
    }
  }
}