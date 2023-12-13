import { Category, CategoryId } from '../bean/CategoryModel'
import {MenuInfo} from '../bean/MenuModel'
import HashMap from '@ohos.util.HashMap'
// export function getFoodCategories(): Category[] {
//   return [{ id: CategoryId.Vegetable, name: $r('app.string.category_vegetable') },
//     { id: CategoryId.Fruit, name: $r('app.string.category_fruit') },
//     { id: CategoryId.Meat, name: $r('app.string.category_meat') },
//     { id: CategoryId.Seafood, name: $r('app.string.category_seafood') },
//     { id: CategoryId.Dessert, name: $r('app.string.category_dessert') }]
// }

export function getChineseCategories(): string[]{
  return ['水果', '蔬菜', '肉类', '海鲜','零食','其他']
}

export function getEnglishCategories(): string[]{
  return ['FRUIT', 'VEGETABLE', 'MEAT', 'SEAFOOD','SNACK','OTHER']
}

export function Eng2Chn(cate: string): string{
  let ret = "";
  switch (cate) {
    case 'FRUIT':
      ret = '水果';
      break;
    case 'VEGETABLE':
      ret = '蔬菜';
      break;
    case 'MEAT':
      ret = '肉类';
      break;
    case 'SEAFOOD':
      ret = '海鲜';
      break;
    case 'SNACK':
      ret = '零食';
      break;
    case 'OTHER':
      ret = '其他';
      break;
    default:
  }
  return ret;
}

export function getCategoriesImage(category: string): Resource{
  switch (category) {
    case 'VEGETABLE':
      return $r('app.media.vegetable')
    case 'FRUIT':
      return $r("app.media.fruit")
    case 'MEAT':
      return $r('app.media.meals')
    case 'SEAFOOD':
      return $r("app.media.seafood")
    case 'SNACK':
      return $r('app.media.snacks')
    case 'OTHER':
      return $r("app.media.others")
    default:
      console.log("无法识别的食物类型")
      return $r('app.media.default_pho')
      break;
  }
}

export function getMenus(): Array<MenuInfo> {
  let menuArray : Array<MenuInfo> = [
    menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, menu9, menu10
  ]
  return menuArray;
}

export function getFoodInfokey(s){
  let array = new Map([
    ['名字','name'],
    ['种类','category'],
    ['食物存量','quantity'],
    ['保质期','shelfLife'],
    ['存放位置','addr']
  ])
  return array.get(s)
}

export let menu1: MenuInfo = new MenuInfo(0, 'menu1', 'menu1', $r('app.media.menu1'))
export let menu2: MenuInfo = new MenuInfo(1, 'menu2', 'menu2', $r('app.media.menu1'))
export let menu3: MenuInfo = new MenuInfo(2, 'menu3', 'menu3', $r('app.media.menu1'))
export let menu4: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu5: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu6: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu7: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu8: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu9: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))
export let menu10: MenuInfo = new MenuInfo(3, 'menu4', 'menu4', $r('app.media.menu1'))

// export const SERVER_ADDR: string = '172.31.119.18:8080'
export const SERVER_ADDR: string = '172.31.39.198:8080'