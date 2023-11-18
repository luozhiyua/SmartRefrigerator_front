import {MenuIngredient} from './MenuIngredient'
export class MenuInfo{
  image: Resource
  name: string
  ingredients: Array<MenuIngredient>
  steps: Array<string>

  constructor(image: Resource, name: string, ingredients: Array<MenuIngredient>, steps: Array<string>) {
    this.image = image
    this.name = name
    this.ingredients = ingredients
    this.steps = steps
  }

}