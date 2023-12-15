import { SERVER_ADDR } from '../../util/DataUtil'
import http from '@ohos.net.http'
@Component
export struct MenuImage {
  private menuId: Number
  private image: ResourceStr
  private name: string
  private userID: string = AppStorage.Link('userID').get();
  @State is_collected: boolean = false;

  aboutToAppear() {
    let httpRequest = http.createHttp();
    let url = "http://" + SERVER_ADDR + "/menu/collection" + `/${this.menuId}`+`/${this.userID}`
    let promise = httpRequest.request(url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        readTimeout: 60000,
        connectTimeout: 60000
      });
    promise.then((data) => {
      console.info(data.result.toString())
      if (data.result.toString() == "true"){
        this.is_collected = true;
      } else {
        this.is_collected = false;
      }
    }).catch((err) => {
      console.info('error:' + JSON.stringify(err));
    });
  }

  build() {
    Column(){
      Image(this.image).width('100%').height('30%')

      Row(){
        Text(this.name)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ left : 18, bottom: 18, top : 5 })

        if (this.is_collected) { //已收藏
          Button("取消收藏")
            .onClick(()=>{
              let httpRequest = http.createHttp();
              httpRequest.request(
                SERVER_ADDR+"/menu/uncollect-menu"+`/${this.menuId}` + `/${this.userID}`,
                {
                  method: http.RequestMethod.PUT,
                  header: {
                    'Content-Type': 'application/json'
                  },
                  extraData:{
                  }
                },(err,data)=>{
                // 考虑弹窗提醒结果
              })
              this.is_collected = false;
            })
        } else {
          Button("收藏")
            .onClick(()=>{
              let httpRequest = http.createHttp();
              httpRequest.request(
                SERVER_ADDR+"/menu/collect-menu"+`/${this.menuId}` + `/${this.userID}`,
                {
                  method: http.RequestMethod.PUT,
                  header: {
                    'Content-Type': 'application/json'
                  },
                  extraData:{
                  }
                },(err,data)=>{
                // 考虑弹窗提醒结果
              })
              this.is_collected = true;
            })
        }

      }
      .width('100%')
      .justifyContent(FlexAlign.Start)


    }
    .justifyContent(FlexAlign.Start)
  }
}
