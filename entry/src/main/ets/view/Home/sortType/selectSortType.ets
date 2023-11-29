// xxx.ets
@Entry
@Component
export struct SelectExample {
  build() {
    Row(){
      Column() {
        Select([{ value: '按名称排序', icon: $r("app.media.ic_files_name_drive") },
          { value: '按保质期排序', icon: $r("app.media.ic_files_time_drive") },])
          .selected(0)
          .value('排序方式')
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .onSelect((index: number) => {
            console.info('Select:' + index)
          })
      }
    }

  }
}