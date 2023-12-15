export class MenuInfo {
  id: number = 0;
  letter: string = '';
  name: string | Resource = ''
  image: Resource | null = null;
  food: Array<number> = [];
  method: string = '';


  constructor(id: number = 0, name: string | Resource = '', image: Resource | null = null) {
    this.id = id;
    this.name = name;
    this.image = image;
  }
}