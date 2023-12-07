@Component
export struct MenuImage {
  private image: string
  private name: string

  build() {
    Column(){
      Image(this.image).width('100%').height('30%')

      Row(){
        Text(this.name)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ left : 18, bottom: 18, top : 5 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)


    }
    .justifyContent(FlexAlign.Start)
  }
}
