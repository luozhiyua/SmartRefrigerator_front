@Component
export struct UserRes {
  @Prop item: string
  staticItem: string
  whe_static: boolean

  build() {
    Flex({ alignItems: ItemAlign.Start }) {
      Row().width(55)

      Column(){
        Row().height(6)
        Row(){
          Text(this.whe_static ? this.staticItem : this.item)
            .fontSize(21)
            .margin({
              left: '2%',
              right: '2%',
              top: '2%',
              bottom: '2%'
            })
            .width("95%")

        }.backgroundColor("#f6fbff")
        .borderRadius(10)
        Row().height(7)
      }.width("70%")

      Row() {
        Image($r('app.media.user'))
          .height(50)
          .width(50)
          .padding({ right: 0 })
      }
    }.width('100%')
  }
}