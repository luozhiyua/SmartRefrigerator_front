export class MenuInfo {
  id: number = 0;
  letter: string = '';
  name: string | Resource = ''
  image: Resource | null = null;
  food: Array<number> = [];
  method: string = '';


  constructor(id: number = 0, letter: string, name: string | Resource = '', image: Resource | null = null) {
    this.id = id;
    this.letter = letter;
    this.name = name;
    this.image = image;
  }
}