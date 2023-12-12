import {Login, AuthMode} from "@ohos/agconnect-auth-component";

@Entry
@Component
struct test{
  build(){
    Column() {
      Login({
        modes: [AuthMode.PASSWORD, AuthMode.PHONE_VERIFY_CODE, AuthMode.MAIL_VERIFY_CODE],
        onSuccess: (user) => {
          AlertDialog.show({
            title: 'authInfo',
            message: JSON.stringify(user)
          })
        }
      }){
        Text('Login').decoration({ type: TextDecorationType.Underline });
      }
    }
  }
}