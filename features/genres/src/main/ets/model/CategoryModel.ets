import { SubCategory } from './SubcategoryModel';

export class Category {
  id: number;
  name: string;
  subCategories: SubCategory[];

  constructor(id: number, name: string, subcategories: SubCategory[]) {
    this.id = id;
    this.name = name;
    this.subCategories = subcategories;
  }
}
