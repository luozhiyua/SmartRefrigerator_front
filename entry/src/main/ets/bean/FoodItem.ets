export default class FoodItem{
  id: number;
  name: string;
  shelfLife: string;
  quantity: string;
  category: string;
  addr: string;

  constructor(id,name,shelfLife,quantity,category,addr) {
    this.id = id;
    this.name = name;
    this.shelfLife = shelfLife;
    this.quantity = quantity;
    this.category = category;
    this.addr = addr;
  }
}