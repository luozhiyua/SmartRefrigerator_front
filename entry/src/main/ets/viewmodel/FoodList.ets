import FoodItem from '../bean/FoodItem';
import http from '@ohos.net.http';

export default class FoodList{
  public foodList: Array<FoodItem> = [];

  constructor() {
    this.foodList = new Array<FoodItem>();
  }

  initData(){
    // TODO: 从远处 GET
    let httpRequest = http.createHttp();
    httpRequest.request(
      "http://localhost:8080/contact",
      {
        method: http.RequestMethod.GET,
      }, (err, data) => {
      if (!err) {
        console.info('get it ! '+ data);
      } else {
        console.info('error:' + JSON.stringify(err));
      }
      httpRequest.destroy();
    }
    );

  }



}
