@Component
export default struct ChefRes {
  item: string
  build() {
    Row() {
      Image($r('app.media.chef'))
        .width(60)
      .margin({ top: "10vp", bottom: " 8vp" })
        //.backgroundColor(Color.White)
      Column().width(3.5)
      Row(){
        Text(this.item)
          .fontSize(18)
          .width("80%")
          .margin({
            left: '2%',
            right: '2%',
            top: '2%',
            bottom: '2%'
          })
      }
      .backgroundColor("#f6fbff")
      .width("81%")
      .borderRadius(10)
    }
    .width("97%")
  }
}