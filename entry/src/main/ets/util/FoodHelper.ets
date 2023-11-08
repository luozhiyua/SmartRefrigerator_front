import http from '@ohos.net.http';
import FoodItem from '../bean/FoodItem';

// todo： 应该是不用这个文件了

@CustomDialog
struct CustomDialogExample {
  message : string;
  controller: CustomDialogController
  // TODO: confirm需添加什么内容
  confirm: () => void
  build() {
    Column() {
      Text(this.message).fontSize(20).margin({ top: 10, bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
      Button('confirm')
        .onClick(() => {
          this.controller.close()
          this.confirm()
        }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

export class FoodHelper {
  // TODO: 每次调用都要new一个这样的对象，也不太合理
  @State message : string = '';
  SERVER_ADDR = "http://localhost:8080";

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({message : this.message}),
  })

  // 目前有 单个食物的 post,put，食物列表的get(带有参数表示排序方式，后续可能增加搜索框)，

  postFoodItem(foodItem: FoodItem) {
    let httpRequest = http.createHttp();
    httpRequest.request(
      this.SERVER_ADDR+"/food",
      {
        method: http.RequestMethod.POST,
        extraData: {
          "foodItem": foodItem,
        },
      }, (err, data) => {
          if (!err) {
            this.message = "操作成功！"
          } else {
            // TODO : 这种提示方式显然不合理
            this.message = "出错啦！" + err;
          }
          this.dialogController.open()
      }
    )
    httpRequest.destroy();
  }

  getFoodList() : Array<FoodItem> {

    return

  }

  putFoodItem(foodItem: FoodItem) {
    let httpRequest = http.createHttp();
    httpRequest.request(
      "/food",
      {
        method: http.RequestMethod.PUT,
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/json'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "foodItem": foodItem,
        },
      }, (err, data) => {
      if (!err) {
        // 弹窗提示post成功
      } else {
        // 弹窗提示post失败
        // 当该请求使用完毕时，调用destroy方法主动销毁
        // httpRequest.destroy();
      }
    }
    )
    httpRequest.destroy();
  }
}




