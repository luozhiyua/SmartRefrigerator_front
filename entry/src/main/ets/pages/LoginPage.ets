
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { SERVER_ADDR, showToastContent } from '../util/DataUtil'
import http from '@ohos.net.http'
/**
 * The login page consists of two components.
 * LoginTitle and LoginBottom, which can be invoked by directly referencing the control.
 */

@Entry
@Component
struct LoginPage {
  @Provide whe_register: boolean = false

  build() {
    Column() {
      LoginTitle()
      LoginBottom()
    }
    .backgroundColor('#F1F3F5')
  }
}

@Component
struct LoginTitle {
  @Consume whe_register: boolean

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(78)
        .height(78)
        .margin({ bottom: 8 })
      Text(this.whe_register ? '注册页面' : '登录页面')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
    }
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('40%')
  }
}

@Component
struct LoginBottom {
  @Consume whe_register: boolean
  @State phoneNum: string = '';
  @State password: string = '';
  @State password2: string = '';

  build() {
    Column() {
      Column() {
        TextInput({ placeholder: '手机号' })
          // .maxLength(11)
          .type(InputType.PhoneNumber)
          .inputStyle()
          .onChange((value: string) => {
            this.phoneNum = value;
          })

        Line()
          .width('100%')
          .height(0.5)
          .margin({
            left: 12,
            right: 12
          })
          .backgroundColor('#0D182431')

        TextInput({ placeholder: '密码' })
          .maxLength(8)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value;
          })

        if(this.whe_register){
          Line()
            .width('100%')
            .height(0.5)
            .margin({
              left: 12,
              right: 12
            })
            .backgroundColor('#0D182431')

          TextInput({ placeholder: '再次输入密码' })
            .maxLength(8)
            .type(InputType.Password)
            .inputStyle()
            .onChange((value: string) => {
              this.password2 = value;
            })
        }
      }
      .backgroundColor(Color.White)
      .borderRadius(24)

      Button(this.whe_register ? '注册' : '登录')
        // .id('loginButtonId')
        .width('100%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#007DFF')
        .margin({
          top: 68,
          bottom: 12
        })
        .onClick(() => {
          if(!this.whe_register){
            let httpRequest = http.createHttp();
            let url = "http://" + SERVER_ADDR + "/user/login"
            let promise = httpRequest.request(url,
              {
                method: http.RequestMethod.POST,
                header: {
                  'Content-Type': 'application/json'
                },
                extraData: {
                  "username": this.phoneNum,
                  "password": this.password
                },
                readTimeout: 60000,
                connectTimeout: 60000
              });
            promise.then((data) => {
              const userID = JSON.parse(data.result.toString())
              console.info(data.result.toString())
              if(userID == -1){
                showToastContent("密码错误")
              }else if(userID == -2){
                showToastContent("用户不存在")
              }else {
                AppStorage.SetOrCreate('userID', userID);
                AppStorage.SetOrCreate('phoneNum', this.phoneNum);
                router.replaceUrl({url: 'pages/Index'})
              }
            }).catch((err) => {
              showToastContent(JSON.stringify(err))
              console.log(JSON.stringify(err))
            });
          }else {
            if (this.password != this.password2) {
              showToastContent('两次输入密码不同')
            } else {
              let httpRequest = http.createHttp();
              httpRequest.request(
                SERVER_ADDR + "/user/registry",
                {
                  method: http.RequestMethod.POST,
                  header: {
                    'Content-Type': 'application/json'
                  },
                  extraData: {
                    username: this.phoneNum,
                    password: this.password
                  }
                }, (err, data) => {
                  const re_msg = JSON.parse(data.result.toString())
                  if(re_msg.code == 201){
                    showToastContent("注册成功")
                    this.whe_register = false
                  }else if(re_msg.code == 409){
                    showToastContent("名称已存在，注册失败")
                  }
              })
              httpRequest.destroy();
            }
          }
        })

      if(!this.whe_register){
        Text('注册')
          .fontColor('#007DFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.whe_register = true;
          })
      }
    }
    .padding({
      left: 12,
      right: 12,
    })
    .backgroundColor('#F1F3F5')
    .height('60%')
  }
}

@Extend(TextInput) function inputStyle() {
  .placeholderColor('#99182431')
  .height(48)
  .fontSize(16)
  .backgroundColor(Color.White)
  .margin({ top: 4})
  .padding({ left: 12 })
}