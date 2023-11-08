import router from '@ohos.router';
import FoodItem from '../bean/FoodItem';

// const params = router.getParams(); // 获取传递过来的参数对象
// const foodItem = params['foodItem']; // 获取id属性的值

@Entry
@Component
struct EditFoodPage {
  clickAction: Function = () => {}; // 分为 POST 或 PUT，只需要在跳转时赋值
  // TODO: 对于列表内 item 输入，默认值为 foodItem 的值即可。
  // TODO：需要判断单项是否为 null。因为 HomeComponent传递的可能为 new FoodItem(null,null,null,null)，或考虑改进这种写法

  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}