import { Category, CategoryId } from '../bean/CategoryModel'

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

export const SERVER_ADDR: string = 'localhost:8080'