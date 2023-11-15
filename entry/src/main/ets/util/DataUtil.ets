import { Category, CategoryId } from '../bean/CategoryModel'
import {MenuInfo} from '../bean/MenuModel'
// export function getFoodCategories(): Category[] {
//   return [{ id: CategoryId.Vegetable, name: $r('app.string.category_vegetable') },
//     { id: CategoryId.Fruit, name: $r('app.string.category_fruit') },
//     { id: CategoryId.Meat, name: $r('app.string.category_meat') },
//     { id: CategoryId.Seafood, name: $r('app.string.category_seafood') },
//     { id: CategoryId.Dessert, name: $r('app.string.category_dessert') }]
// }

export function getStringCategories(): string[]{
  return ['蔬菜', '水果', '肉类', '海鲜','零食']
}

export function getMenus(): Array<MenuInfo> {
  let menuArray : Array<MenuInfo> = [
    menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, menu9, menu10
  ]
  return menuArray;
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

export const SERVER_ADDR: string = 'localhost:8080'