@Component
export default struct ChefTitle {
  build() {
    Text("聊天")
      .fontWeight(FontWeight.Bolder)
      .fontSize("32fp")
      .alignSelf(ItemAlign.Start)
      .margin({
        left: '8%',
        top: '5%',
        bottom: '5%'
      })
      .height("32vp")
  }
}