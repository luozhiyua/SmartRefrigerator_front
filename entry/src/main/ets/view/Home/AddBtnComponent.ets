@Styles function allSize () {
  .width('100%')
  .height('100%')
}

@Component
export default struct AddBtn {
  clickAction: Function = () => {};

  build() {
    Button({ type: ButtonType.Circle, stateEffect: false }) {
      Image($r('app.media.increase'))
        .allSize()
        .borderRadius('50%')
    }
    .backgroundColor($r("app.color.white"))
    .onClick(() => this.clickAction())
    .zIndex(2)
    .position({ x: '83%', y: '88%' })
    .width($r('app.float.default_48'))
    .height($r('app.float.default_48'))
  }
}