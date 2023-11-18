@Component
export default struct ChefRes {
  build() {
    Row() {
      Image($r('app.media.chef'))
        .width("60vp")
        .margin({ top: "10vp", bottom: "8vp" })
      Text("我是厨师机器人，你可以向我咨询菜谱")
        .fontSize(18)
        .backgroundColor("#faf8fc")
        .width("80%")
        .height("60vp")
        .margin({
          left: '5%',
          right: '5%'
        })
    }
    .width("90%")
  }
}