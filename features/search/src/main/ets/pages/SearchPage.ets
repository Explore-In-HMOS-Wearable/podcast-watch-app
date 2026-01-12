import { ArcList, ArcListItem,ArcListAttribute,ArcListItemAttribute, ComponentContent } from '@kit.ArkUI';
import { CommonModule } from 'commons';
import { SongModel } from 'commons/src/main/ets/models/SongModel';
import { SearchPageViewModel } from '../viewmodels/SearchPageViewModel';

@Builder
function buildText() {
  Column() {
    Text($r('app.string.label_search'))
      .fontSize('18fp')
      .fontWeight(FontWeight.Bold)
      .fontColor($r('app.color.button_color'));
  }
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .margin({ top: 10, bottom: 0 })
  .width('80%')
}


@Component
export struct SearchPage {
  context: UIContext = this.getUIContext();
  header: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));
  searchPageViewModel: SearchPageViewModel = new SearchPageViewModel()
  commonModule: CommonModule = CommonModule.getInstance();
  pageInfos: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    this.commonModule.appService.searchPageReloadCount = 0;
  }

  @Builder
  songListItem(item: SongModel) {
    ArcListItem() {
      Row() {
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
      }.width('90%')
      .borderRadius(48)
      .backgroundColor($r('app.color.menu_item_background'))
      .onClick(() => {
        this.searchPageViewModel.songItemOnClick(item);
      })
    }
    .width('90%')
    .margin({ top: 10 })
  }

  build() {

    NavDestination() {

      ArcList({
        initialIndex: 1,
        header: this.header
      }) {

        ArcListItem() {
          Search()
            .width('90%')
            .textFont({ size: 12 })
            .margin(0)
            .onChange((value) => {
              this.searchPageViewModel.searchOnChange(value);
            })
        }.width('90%');

        if (this.searchPageViewModel.appService.searchKey.length > 0) {
          ForEach(this.searchPageViewModel.appService.filteredSongs,
            (item: SongModel, index: number) => {
              this.songListItem(item);
            }, (item: string, index: number) => item)
        }

        if (this.searchPageViewModel.appService.searchKey.length > 0) {
          ArcListItem() {
            Row() {
              Image(this.commonModule.commonMedia.reload)
                .width(35)
                .height(35)
                .fillColor(Color.White)
                .margin({ top: 10 })
                .onClick(() => {
                  this.commonModule.appService.reloadOnClick();
                })
            }
            .justifyContent(FlexAlign.Center)
            .width('90%')
          }
        }


        if (this.searchPageViewModel.appService.searchKey.length === 0) {
          ArcListItem() {
            Row() {
              Text($r('app.string.label_previous'))
                .fontSize('18fp')
                .fontColor($r('app.color.button_color'));
            }
            .justifyContent(FlexAlign.Center)
            .width('90%')
          }
          .width('90%')
          .margin({ top: 10 })
        }
        if (this.searchPageViewModel.appService.searchKey.length === 0) {
          ForEach(this.commonModule.appService.previousSearches, (item: SongModel, index: number) => {
            this.songListItem(item);
          }, (item: string, index: number) => item)
        }

      }
      .width('100%')
      .height('100%')
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