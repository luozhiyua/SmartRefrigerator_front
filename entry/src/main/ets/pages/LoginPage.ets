
import router from '@ohos.router'
/**
 * The login page consists of two components.
 * LoginTitle and LoginBottom, which can be invoked by directly referencing the control.
 */
@Entry
@Component
struct LoginPage {
  build() {
    Column() {
      LoginTitle()
      LoginBottom()
    }
    .backgroundColor('#F1F3F5')
  }
}

@Preview
@Component
struct LoginTitle {
  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(78)
        .height(78)
        .margin({ bottom: 8 })
      Text('登录页面')
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

@Preview
@Component
struct LoginBottom {
  @State account: string = '';
  @State password: string = '';

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
      }
      .backgroundColor(Color.White)
      .borderRadius(24)

      Button('登录')
        .id('loginButtonId')
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
          // TODO: 添加登录逻辑
          // CommonUtils.loginArkTS(this.account, this.password);
          router.replaceUrl({url: 'pages/Index'})
        })
      Text('注册')
        .fontColor('#007DFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          // TODO: 添加注册逻辑
        })
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