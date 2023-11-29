
@Component
export struct FoodSort{
  private isRankSort: Boolean = false

  build(){
    Row(){
      Text('排序:')
        .fontColor('#000000')
        .backgroundColor($r('app.color.white'))
        .width('20%')

      Button("名称", {type: ButtonType.Capsule , stateEffect: true})
        .borderRadius(8)
        .width('35%')
        .height("70%")
        .fontSize(16)
        .fontColor('#000000')
        .onClick(() => {
          console.log('rank change')
          console.log(this.isRankSort == false? 'flase' : 'true')
          this.isRankSort = !this.isRankSort
        })
        .borderRadius(14)
        .backgroundColor(this.isRankSort == false ? $r('app.color.notRankColor') : $r('app.color.isRankColor'))

      Button("保质期", {type: ButtonType.Normal , stateEffect: true})
        .borderRadius(8)
        .width('40%')
        .height("70%")
        .fontSize(16)
        .fontColor('#000000')
        .onClick(() => {
          console.log('rank change')
          console.log(this.isRankSort == false? 'flase' : 'true')
          this.isRankSort = !this.isRankSort
        })
        .borderRadius(14)
        .backgroundColor(this.isRankSort == false ? $r('app.color.isRankColor') : $r('app.color.notRankColor'))
        .margin({right: 0})

    }.backgroundColor($r('app.color.white'))
    .height('6%')
    .width('55%')
    .borderRadius(14)
  }
}