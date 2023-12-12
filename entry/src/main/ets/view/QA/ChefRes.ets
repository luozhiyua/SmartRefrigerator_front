@Component
export default struct ChefRes {
  item: string
  build() {
    Flex({ alignItems: ItemAlign.Start }) {
      Image($r('app.media.chef'))
        .height(50)
        .width(50)

      Column().width(3.5)

      Column(){
        Row().height(6)
        Row(){
          Text(this.item)
            .fontSize(21)
            .margin({
              left: '3%',
              right: '3%',
              top: '2%',
              bottom: '2%'
            })
        }.width("70%")
        .backgroundColor("#f6fbff")
        .borderRadius(10)

        Row().height(7)
      }

    }

  }
}