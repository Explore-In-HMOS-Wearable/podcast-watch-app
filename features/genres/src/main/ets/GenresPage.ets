import { LazyDataSource } from 'generalutils';
import { CategoryTabComponent } from './CategoryTabComponent';
import { Category } from './model/category-model';
import { getCategories } from './viewmodel/category-viewmodel';

@Builder
export function GenresPageBuilder(name: string, param: Object) {
  GenresPage()
}

@Component
export struct GenresPage {
  pageInfos: NavPathStack = new NavPathStack();
  @State message: string = 'GenresPage';
  scroller: Scroller = new Scroller()
  dataSource: LazyDataSource<Category> = new LazyDataSource();

  async aboutToAppear() {
    await this.Init();
  }

  private async Init() {
    let categories = await getCategories(getContext(this))
    this.dataSource.pushArrayData(categories)
  }

  async onPageShow() {
    await this.Init();
  }

  build() {

    NavDestination() {

      Column({ space: 50 }) {
        List() {
          LazyForEach(this.dataSource, (item: Category, index: number) => {
            ListItem() {
              CategoryTabComponent({ category: item })
            }
          }, (item: Category) => item.name)

          ListItem() {
            Text('Transparent').fontColor(Color.Transparent)
              .height('35vp')
          }
        }
        .scrollBar(BarState.Off)
        .enableScrollInteraction(true)
        .scrollSnapAlign(ScrollSnapAlign.NONE)
        .listDirection(Axis.Vertical)
        .edgeEffect(EdgeEffect.Fade)

      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(Color.White)
      .margin({ bottom: '125vp' })
      .height("100%")
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[$r('app.color.base_background_gradient_start'), 0.0],
          [$r('app.color.base_background_gradient_end'), 1],]
      })
    }

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })
  }
}
