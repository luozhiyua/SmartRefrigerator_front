// xxx.ets
@Entry
@Component
export struct popupSortType {
  private select: number = 0
  private sortType: string[] = ['按名称排序', '按保质期排序']

  build() {
    Row() {
        Column() {
          Image($r('app.media.ic_switch') )
            .width('20%')
            .height(25)
            .objectFit(ImageFit.Contain)
          Text('排序方式')
            .fontSize(10)
        }
          .onClick(() => {
            TextPickerDialog.show({
              range: this.sortType,
              selected: this.select,
              onAccept: (value: TextPickerResult) => {
                // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                this.select = value.index
                console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
              },
              onCancel: () => {
                console.info("TextPickerDialog:onCancel()")
              },
              onChange: (value: TextPickerResult) => {
                console.info("TextPickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })
      }
    }

}