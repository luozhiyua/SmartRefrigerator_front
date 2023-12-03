import {MenuInfo} from '../model/MenuInfo'
import {RecipeInfo} from '../common/RecipeDetailConstants'


export class MenuViewModel{

  private menuInfo: MenuInfo = new MenuInfo(RecipeInfo.id,RecipeInfo.image, RecipeInfo.recipe_name, RecipeInfo.ingredients, RecipeInfo.steps)

  public getMenuInfo(): MenuInfo{
    return this.menuInfo;
  }


}