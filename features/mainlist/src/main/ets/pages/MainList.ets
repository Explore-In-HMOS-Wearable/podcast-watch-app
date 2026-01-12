import { CommonModule } from 'commons';
import { SongModel, TmpClass } from 'commons/src/main/ets/models/SongModel';
import { MainListViewModel } from '../viewmodels/MainListViewModel';

@Builder
export function MainListPageBuilder(name: string, param: Object) {
  MainList()
}

@Component
export struct MainList {
  context: UIContext = this.getUIContext();
  searchPageViewModel: MainListViewModel = new MainListViewModel()
  commonModule: CommonModule = CommonModule.getInstance();
  pageInfos: NavPathStack = new NavPathStack();
  @State podcasts: SongModel[] = []
  @State listName: string = ''
  @Provide isMain: boolean = false

  aboutToAppear(): void {
    this.commonModule.appService.searchPageReloadCount = 0;
  }

  @Builder
  songListItem(item: SongModel) {
    ListItem() {
      Row() {
        Blank().width(this.isMain ? '12%' : '5%')
        Image(item.songPic)
          .width(50)
          .height(50)
          .borderRadius(48)
          .objectFit(ImageFit.Cover)
          .margin({ right: 10 })
        Column() {
          Text(item.songName)
            .fontSize('12fp')
            .fontColor(Color.White)
            .margin({ bottom: 2 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(item.songAuthor)
            .fontSize('10fp')
            .fontColor(Color.Gray)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

        }.alignItems(HorizontalAlign.Start).width('60%')
      }.width('100%')
      .borderRadius(48)
      .onClick(() => {
        this.searchPageViewModel.songItemOnClick(item);
      })
    }
    .width('100%')
    .margin({ top: 10 })
  }

  build() {

    NavDestination() {



      List({
        initialIndex: 0
      }) {

        ListItem() {
        Column() {
          Text(this.listName)
            .fontSize('14fp')
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.button_color'));
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ top: '5vp', bottom: 0 })
        .width('97%')
        .height('10%')
        }

        ForEach(this.podcasts,
          (item: SongModel, index: number) => {
            this.songListItem(item);
          }, (item: string, index: number) => item)

        ListItem() {
          Text('')
            .height('35vp')
        }

      }
      .width('100%')
      .height('89%')
      .enableScrollInteraction(true)

    }
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[$r('app.color.base_background_gradient_start'), 0.0],
        [$r('app.color.base_background_gradient_end'), 1],]
    })

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

      this.podcasts = (context.pathInfo.param as TmpClass).podcasts
      this.listName = (context.pathInfo.param as TmpClass).listName

    })
  }
}