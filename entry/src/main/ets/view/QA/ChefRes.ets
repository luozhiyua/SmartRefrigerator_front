@Component
export default struct ChefRes {
  item: string
  build() {
    Row() {
      Image($r('app.media.chef'))
        .width("60vp")
        .margin({ top: "10vp", bottom: "8vp" })
      Text(this.item)
        .fontSize(18)
        .backgroundColor("#faf8fc")
        .width("80%")
        .margin({
          left: '5%',
          right: '5%'
        })
    }
    .width("90%")
  }
}