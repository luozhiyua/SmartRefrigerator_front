import {MenuIngredient} from './MenuIngredient'
export class MenuInfo{
  id:Number
  image: ResourceStr
  name: string
  ingredients: Array<MenuIngredient>
  steps: Array<string>

  constructor(id:Number,image: string, name: string, ingredients: Array<MenuIngredient>, steps: Array<string>) {
    this.id = id
    this.image = image
    this.name = name
    this.ingredients = ingredients
    this.steps = steps
  }

}