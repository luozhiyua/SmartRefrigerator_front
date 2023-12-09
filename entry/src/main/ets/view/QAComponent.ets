import { SERVER_ADDR } from '../util/DataUtil'
import ChefRes from './QA/ChefRes'
import { UserRes } from './QA/UserRes'
import http from '@ohos.net.http'

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height("1vp")
  .backgroundColor("#df73ff")
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

let chefRes: string[] = ["我是厨师机器人"];
let chefResNum: number = 0;

async function postResponse(requestBody: string): Promise<string> {
  const url = "http://" + SERVER_ADDR + "/qa/ques";
  const httpRequest = http.createHttp();

  try {
    const data = await httpRequest.request(
      url,
      {
        method: http.RequestMethod.POST,
        extraData: {
          "userQues": requestBody
        },
        connectTimeout: 60000,
        readTimeout: 60000,
        header: {
          'Content-Type': 'application/json'
        }
      }
    );

    if (data.responseCode === http.ResponseCode.OK) {
      const retValue = data.result.toString();
      // chefRes[chefResNum] = retValue;
      console.info('Result(f):' + data.result);
      return retValue;
    } else {
      console.error('HTTP request failed with response code:', data.responseCode);
      return ''; // or handle the error accordingly
    }
  } catch (error) {
    console.error('Error during HTTP request:', error);
    return ''; // or handle the error accordingly
  } finally {
    httpRequest.destroy();
  }
}

@Component
export default struct QAIndex {
  @State text: string[] = [""]
  @State textNow: string = ""
  @State textLength: number = 1
  alignContent: number = 0
  controller: TextInputController = new TextInputController()
  scroller: Scroller = new Scroller()
  @State whe_loading: boolean = false

  build() {
    Column() {
      Column(){
        //顶部导航栏
        Text('问答小助手')
          .fontSize(29)
          .fontWeight(FontWeight.Bold)
          .padding({ top: 15, bottom: 10, left: 25, right: 20 })
          .alignSelf(ItemAlign.Start)
          .width('100%')
        .backgroundColor('#c0c5ff')
        //  .backgroundColor("#9FA4E2")
      }.height("8%").margin({top: 0})

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
      .linearGradient({
        angle: 90,

        colors: [['#c0c5ff', 0.0] , ["#cdd1ff", 0.5], ["#cdd2ff", 0.9]]

        //colors: [['#9FA4E2', 0.0], ["#cdd2ff", 0.8]]
      })
      //.backgroundColor("#D2E0FB")

      Column(){
        Row() {
          TextInput({ placeholder: 'inline style', controller: this.controller,text: this.textNow})
            .width("62%")
            .height(60)
            .margin(15)
            .fontSize(18)
            .borderRadius(10)
            .backgroundColor('#f0f8ff')
            //.backgroundColor('#ecfdff')
            .style(TextInputStyle.Inline)
            .onChange((value: string) => {
              this.textNow = value
            })

          if(this.whe_loading){
            Text('加载中...').fontSize(20).fontColor('#A9A9A9')
          }else {
            Button('发送')
              .backgroundColor('#ecfdff')
              .type(ButtonType.Normal)
              .fontColor(Color.Black)
              .borderRadius(12)
              .margin(15)
              .onClick(async () => {
                // 使用await等待异步操作完成
                this.whe_loading = true
                const result = await postResponse(this.textNow);
                this.whe_loading = false
                chefResNum++;
                chefRes[chefResNum] = result;

                this.text[this.textLength - 1] = this.textNow;
                this.text[this.textLength] = "";
                this.textNow = "";
                this.textLength++;

                this.scroller.scrollEdge(Edge.End);
              });
          }
        }

      }.backgroundColor('#c7ccff')
      .width('100%')
      .height("28%")
    }
    .height('100%')
  }
}