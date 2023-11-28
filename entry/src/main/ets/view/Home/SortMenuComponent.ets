@Entry
@Component
export struct SortMenuComponent{
  @State select: boolean = true
  private iconStr: ResourceStr = $r("app.media.icon")
  private iconStr2: ResourceStr = $r("app.media.icon")

  @Builder
  MyMenu(){
    Menu() {
      MenuItem({ startIcon: $r("app.media.ic_files_name_drive"), content: "按名称排序" })
        .selected(this.select)
        .enabled(this.select)
        .onClick(() =>{
          this.select = true;
        })
      MenuItem({ startIcon: $r("app.media.ic_files_time_drive"), content: "按保质期排序" })
        .selected(!this.select)
        .enabled(!this.select)
        .onClick(() =>{
          this.select = false;
        })
        /*.onChange((selected) => {

        })*/

    }
  }
  build() {
    Row() {
      Column() {
        Image($r('app.media.ic_switch') )
          .width('20%')
          .height(25)
          .objectFit(ImageFit.Contain)
      }
      .bindMenu(this.MyMenu)

    }

  }
}