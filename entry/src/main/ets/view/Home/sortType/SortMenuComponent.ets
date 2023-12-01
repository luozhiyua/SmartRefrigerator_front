@Styles function RowStyle(){
  .width('100%')
  .height(30)
  .align(Alignment.Center)
}

@Component
export struct SortMenuComponent{
  @Link selectByName: boolean

  @Builder
  MyMenu(){
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Column() {
        Row() {
          Image($r("app.media.ic_files_name_drive")).width(20).height(20).margin({ right: 5 })
          Text(`按保质期排序`).fontSize(15).fontColor(this.selectByName ? '#000000' : '#A9A9A9')
        }.RowStyle()
        .onClick(() => {
          this.selectByName = true
        })

        Divider().height(10).width('80%').color('#ccc')

        Row() {
          Image($r("app.media.ic_files_time_drive")).width(20).height(20).margin({ right: 5 })
          Text(`按名称排序`).fontSize(15).fontColor(this.selectByName ? '#A9A9A9' : '#000000')
        }.RowStyle()
        .onClick(()=>{
          this.selectByName = false
        })
      }
    }.width('50%')
  }
  build() {
    Row() {
      Column() {
        Image($r('app.media.ic_switch') )
          .width('20%')
          .height(25)
          .objectFit(ImageFit.Contain)
        Text('排序方式')
          .fontSize(13)
      }
      .bindMenu(this.MyMenu)

    }

  }
}