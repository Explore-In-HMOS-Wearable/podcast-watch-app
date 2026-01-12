import { Category } from './model/CategoryModel';
import { SubCategory } from './model/SubcategoryModel';
import { CommonModule } from 'commons';
import { TmpClass } from 'commons/src/main/ets/models/SongModel';

@Reusable
@Component
export struct CategoryTabComponent {
  private scroller: Scroller = new Scroller();
  @BuilderParam tabContent?: (index: number) => void
  @Prop category: Category;
  commonModule: CommonModule = CommonModule.getInstance();
  private colorFilterMatrix: number[] = [
    0, 0, 0, 0, 0.6470588235,
    0, 0, 0, 0, 0.6,
    0, 0, 0, 0, 0.6,
    0, 0, 0, 1, 0
  ];
  @State drawingColorFilterFirst: ColorFilter | undefined = new ColorFilter(this.colorFilterMatrix);

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.category.name)
            .fontFamily('roboto_bold')
            .fontWeight(FontWeight.Bold)
            .fontSize('12fp')
            .textAlign(TextAlign.Center)
            .textCase(TextCase.UpperCase)
            .fontColor('#ffa59999')
        }
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {

          this.commonModule.navigationService.pageInfos.pushPathByName('MainListPage',
            new TmpClass(this.commonModule.appService.getAllSongs(), this.category.name, true))
        })

        Blank().width('5vp')

        Column() {
          Image($r('app.media.arrowsvg'))
            .width('15.00vp')
            .colorFilter(this.drawingColorFilterFirst)


        }
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .width('8%')
        .align(Alignment.Center)

      }
      .height('23vp')
      .margin(7)


      Scroll(this.scroller) {
        Row() {
          ForEach(this.category.subCategories, (item: SubCategory, index?: number | undefined) => {
            Column() {
              Row() {
                Image($r('app.media.podcasts'))
                  .grayscale(0.89)
                  .opacity(0.87)
                  .height('37vp')
              }

              Blank()
                .height('5vp')

              Row() {
                Text(item.subCategoryName)
                  .fontFamily('roboto_medium')
                  .fontWeight(FontWeight.Medium)
                  .fontSize('11fp')
                  .textAlign(TextAlign.Center)
                  .height('100%')
                  .textCase(TextCase.Normal)
                  .padding({ left: '1.5vp' })
                  .fontColor('#ffa59999')
                  .onClick(() => {

                    this.commonModule.navigationService.pageInfos.pushPathByName('MainListPage',
                      new TmpClass(this.commonModule.appService.getAllSongs(), item.subCategoryName, true))
                  })
              }
              .height('20%')

            }
            .height('100%')
            .width('65vp')
            .margin('5vp')

          }, (item: string, index: number) => item)


        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .enableScrollInteraction(true)
      .width('100%')
      .height('155vp')
      .margin({
        top: '0.00vp',
        right: '8.00vp',
        bottom: '0.00vp',
        left: '8.00vp'
      })
      .scrollBar(BarState.Off)
    }
    .height('125vp')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}
