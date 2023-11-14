export enum CategoryId {
  Vegetable= 0,
  Fruit,
  Meat,
  Seafood,
  Dessert
}

export class Category {
  name: Resource | null = null;
  id: CategoryId | null = null;
}


