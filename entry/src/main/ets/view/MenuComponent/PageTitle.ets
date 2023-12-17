import router from '@ohos.router'
@Component
export struct PageTitle {
  foodName: string

  build() {
    Row() {
      Image($r('app.media.back'))
        .width(20)
        .height(20)
        .onClick(() => {
          router.back()
        })
      Text('菜谱详情')
        .fontSize(25)
        .margin({ left: 20 })
    }
    .padding(12)
    .width('100%')
    .backgroundColor('#EDF2F5')
  }
}