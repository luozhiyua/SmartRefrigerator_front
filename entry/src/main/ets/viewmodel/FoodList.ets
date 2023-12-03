// import FoodItem from '../bean/FoodItem';
// import http from '@ohos.net.http';
// import { Category, CategoryId } from '../bean/CategoryModel';
// import { SERVER_ADDR } from '../util/DataUtil';
//
// export default class FoodList{
//   public foodList: FoodItem[];
//
//   constructor() {
//     this.foodList = new Array<FoodItem>();
//   }
//   getData(){
//     return this.foodList;
//   }
//
//   initData(){
//     //
//     /*let httpRequest = http.createHttp();
//     let url = "http://"+SERVER_ADDR+"/foods-by-date"
//     let promise = httpRequest.request(
//       url,
//       {
//         method: http.RequestMethod.GET,
//         connectTimeout: 60000,
//         readTimeout: 60000,
//         header: {
//           'Content-Type': 'application/json'
//         }
//       });
//     promise.then((data) => {
//       console.info('Result:' + data.result);
//       console.info('code:' + data.responseCode);
//
//       for (let index = 0; index < data.result.toString().length; index++) {
//         const element = data.result[index];
//         this.foodList.push(new FoodItem(element.id, element.name, element.freshDate, "10个", element.category, "冷藏1层"))
//       }
//     }).catch((err) => {
//       console.info('error:' + JSON.stringify(err));
//     });
//     httpRequest.destroy();*/
//
//     this.foodList.push(new FoodItem(1,"鸡蛋","3天","10个","肉类","冷藏1层"));
//     this.foodList.push(new FoodItem(2,"鸡肉","3天","10个","肉类","冷藏1层"));
//     this.foodList.push(new FoodItem(3,"生菜","3天","10个","蔬菜","冷藏1层"));
//     this.foodList.push(new FoodItem(4,"苹果","3天","10个","水果","冷藏1层"));
//     this.foodList.push(new FoodItem(5,"白菜","3天","10个","蔬菜","冷藏1层"));
//     this.foodList.push(new FoodItem(6,"猪肉","3天","10个","肉类","冷藏1层"));
//     this.foodList.push(new FoodItem(7,"螃蟹","3天","10个","海鲜","冷冻1层"));
//     this.foodList.push(new FoodItem(8,"巧克力","3天","10个","零食","冷藏1层"));
//     this.foodList.push(new FoodItem(9,"可乐","3天","10个","其他","冷藏1层"));
//
//
//   }
//
//
// }
