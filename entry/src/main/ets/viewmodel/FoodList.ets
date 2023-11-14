import FoodItem from '../bean/FoodItem';
import http from '@ohos.net.http';
import { Category, CategoryId } from '../bean/CategoryModel';
import { SERVER_ADDR } from '../util/DataUtil';

export default class FoodList{
  public foodList: FoodItem[];

  constructor() {
    this.foodList = new Array<FoodItem>();
  }
  getData(){
    return this.foodList;
  }

  initData(){
    // TODO: 从远处 GET
    // let httpRequest = http.createHttp();
    // httpRequest.request(
    //   SERVER_ADDR+'/foodList',
    //   {
    //     method: http.RequestMethod.GET,
    //   }, (err, data) => {
    //   if (!err) {
    //     // 数据处理
    //     console.info('get it ! '+ data);
    //   } else {
    //     console.info('error:' + JSON.stringify(err));
    //   }
    //   httpRequest.destroy();
    // });

    this.foodList.push(new FoodItem(1,"鸡蛋","3天","10个","肉类","冷藏1层"));
    this.foodList.push(new FoodItem(2,"鸡肉","3天","10个","肉类","冷藏1层"));
    this.foodList.push(new FoodItem(3,"生菜","3天","10个","蔬菜","冷藏1层"));
    this.foodList.push(new FoodItem(4,"苹果","3天","10个","水果","冷藏1层"));
    this.foodList.push(new FoodItem(5,"白菜","3天","10个","蔬菜","冷藏1层"));
    this.foodList.push(new FoodItem(6,"猪肉","3天","10个","肉类","冷藏1层"));

  }


}
