export class SubCategory {
  id: number;
  subCategoryName: string;
  mainCategoryId: number;
  bookCount: number;
  url: string;

  constructor(
    id: number,
    subCategoryName: string,
    mainCategoryId: number,
    bookCount: number,
    url: string
  ) {
    this.id = id;
    this.subCategoryName = subCategoryName;
    this.mainCategoryId = mainCategoryId;
    this.bookCount = bookCount;
    this.url = url;
  }
}