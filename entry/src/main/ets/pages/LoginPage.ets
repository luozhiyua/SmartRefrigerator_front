
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { showToastContent } from '../util/DataUtil'
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
  @State account: string = '';
  @State password: string = '';
  @State password2: string = '';

  build() {
    Column() {
      Column() {
        TextInput({ placeholder: '账号' })
          .maxLength(11)
          .type(InputType.Number)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value;
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
            // TODO: 添加登录逻辑 , 将 this.account, this.password 进行 submit, 返回是否认证成功与userId。
            AppStorage.SetOrCreate('userID', '返回的用户id');
            AppStorage.SetOrCreate('userName', this.account);
            router.replaceUrl({url: 'pages/Index'})
          }else{
            if(this.password != this.password2){
              showToastContent('两次输入密码不同')
            }else {
              // TODO: 添加注册逻辑，将 this.account, this.password 进行 submit, 返回用户id。
              this.whe_register = false
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