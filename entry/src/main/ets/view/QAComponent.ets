import { SERVER_ADDR } from '../util/DataUtil'
import ChefRes from './QA/ChefRes'
import ChefTitle from './QA/ChefTitle'
import { UserRes } from './QA/UserRes'
import http from '@ohos.net.http'

let retValue:string = "";
let chefRes: string[] = ["我是厨师机器人"]
let chefResNum: number = 1

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height("1vp")
  .backgroundColor("#df73ff")
}

//TODO（http）
function postResponse({requestBody: str}): string{
  let url="http://"+SERVER_ADDR+"/qa/ques"
  let httpRequest = http.createHttp();
  let requestBody: string = str;
  let promise = httpRequest.request(
    // 请求url地址
    url,
    {
      // 请求方式
      method: http.RequestMethod.POST,
      // 请求的额外数据。
      extraData: {
        "userQues": requestBody
      },
      // 可选，默认为60s
      connectTimeout: 60000,
      // 可选，默认为60s
      readTimeout: 60000,
      // 开发者根据自身业务需要添加header字段
      header: {
        'Content-Type': 'application/json'
      }
    });
  promise.then((data) => {
    if (data.responseCode === http.ResponseCode.OK) {
      console.info('Result(f):' + data.result);
      retValue = data.result.toString();
      chefRes[chefResNum++] = retValue
      httpRequest.destroy();
    }
  }).catch((err) => {
    console.info('error:' + JSON.stringify(err));
    httpRequest.destroy();
    return null;
  });
  return "";
}

@Component
export default struct QAIndex {
  @State text: string[] = [""]
  @State textNow: string = ""
  @State textLength: number = 1
  alignContent: number = 0
  controller: TextInputController = new TextInputController()
  scroller: Scroller = new Scroller()

  build() {
    Column() {
      Column(){
        //顶部导航栏
        Text('问答小助手')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .padding({ top: 15, bottom: 10, left: 20, right: 20 })
          .alignSelf(ItemAlign.Start)
          .width('100%')
          .backgroundColor($r('app.color.startColor'))
      }

      Column(){
        Scroll(this.scroller) {
          Column() { //未来改成scroll
            ForEach(this.text, (item, index) => {
              ChefRes({item: chefRes[index]})
              if (index == this.textLength - 1) {
                UserRes({item: this.textNow,whe_static: false})
              } else {
                UserRes({staticItem: item, item: '',whe_static: true})
              }
            })
          }.width('95%')
        }
        .width('100%')
        .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
        .scrollBar(BarState.On)  // 滚动条常驻显示
        .scrollBarColor(Color.Gray)  // 滚动条颜色
        .scrollBarWidth(10) // 滚动条宽度
        .edgeEffect(EdgeEffect.None)
      }.height('80%')

      Column(){
        Row() {
          TextInput({ placeholder: 'inline style', controller: this.controller })
            .width("60%")
            .height(60)
            .margin(20)
            .fontSize(18)
            .borderRadius(0)
            .style(TextInputStyle.Inline)
            .onChange((value: string) => {
              this.textNow = value
            })
          Button('发送')
            .margin(15)
            .onClick(() => {
              this.text[this.textLength - 1] = this.textNow;
              this.text[this.textLength] = ""
              postResponse({ requestBody: this.textNow })
              this.textNow = "";
              this.textLength++

              // TODO: 因为click后有长度增加，所以每次总是差一个的长度，如何才能使之每次滚动到最下栏
              this.scroller.scrollEdge(Edge.End)
            })
        }
        .margin({
          bottom: "3%"
        })
      }
    }
    .height('100%')
  }
}