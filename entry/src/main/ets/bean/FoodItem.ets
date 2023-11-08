export default class FoodItem{
  id: number;
  name: string;
  shelfLife: string;
  quantity: number;

  constructor(id,name,shelfLife,quantity) {
    this.id = id;
    this.name = name;
    this.shelfLife = shelfLife;
    this.quantity = quantity;
  }
}