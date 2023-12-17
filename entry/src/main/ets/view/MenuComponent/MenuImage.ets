@Component
export struct MenuImage {
  private image: ResourceStr
  private name: string
  @Consume is_collected: boolean

  build() {
    Column(){
      Image(this.image).width('100%').height('30%')

      Flex({justifyContent: FlexAlign.SpaceBetween}){
        Text(this.name)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ left : 18, bottom: 18, top : 5 })

        Image(this.is_collected ? $r("app.media.collect") : $r("app.media.uncollect"))
            .height("6%")
            .onClick(()=>{
              this.is_collected = !this.is_collected;
            }).margin({right : 8})
      }
      .width('100%')
      .margin({left: 8, right: 12})

    }
    .justifyContent(FlexAlign.Start)
  }
}
