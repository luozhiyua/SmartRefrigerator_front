@Component
export struct UserRes{
  @Prop item: string
  staticItem: string
  whe_static: boolean

  build() {
    Row() {
      Text(this.whe_static ? this.staticItem : this.item)
        .fontSize(18)
        .backgroundColor("#dcdcdc")
        .width("80%")
        .margin({
          right: '5%'
        })
        .padding({
          left: '5%',
          right: '5%'
        })
      Image($r('app.media.user'))
        .width("60vp")
        .height("60vp")
        .margin({ top: "10vp", bottom: "8vp" })
    }
    .width("90%")
  }
}