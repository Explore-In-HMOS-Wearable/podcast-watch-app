import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent } from '@kit.ArkUI';
import { CommonModule } from 'commons';
import { SongModel } from 'commons/src/main/ets/models/SongModel';
import { DownloadsViewModel } from '../viewmodels/DownloadsViewModel';

@Component
export struct Downloads {
  downloadsVm: DownloadsViewModel = new DownloadsViewModel();
  commonModule: CommonModule = CommonModule.getInstance();
  pageInfos: NavPathStack = new NavPathStack();

  @Builder
  songListItem(item: SongModel) {
    ArcListItem() {
      Row() {
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
              .textOverflow({ overflow: TextOverflow.Ellipsis });
            Text(item.songAuthor)
              .fontSize('10fp')
              .fontColor(Color.Gray)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis });
          }.alignItems(HorizontalAlign.Start).width('40%')
        }

        Image(item.isDownloaded ? $r('app.media.downloads') : $r('app.media.download'))
          .width(item.isDownloaded ? 30 : 25)
          .height(item.isDownloaded ? 30 : 25)
          .fillColor(item.isDownloaded ? $r('app.color.button_color') : Color.White)
          .margin({ right: 10 })
          .onClick(() => {
            this.downloadsVm.changeDownloadStatus(item);
          })


      }
      .width('90%')
      .borderRadius(48)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.menu_item_background'))
      .onClick(() => {
        this.commonModule.appService.currentSong = item;
        this.commonModule.appService.previousSearches.push(item);
        this.commonModule.navigationService.pageInfos.pushPath({ name: 'Player' })
      })
    }
    .width('90%')
    .margin({ top: 10 })
  }

  build() {

    NavDestination() {

      ArcList() {

      ForEach(this.commonModule.appService.getDownloads(), (item: SongModel, index: number) => {
        this.songListItem(item);
      }, (item: SongModel) => item.songName)

      ArcListItem() {
        if (this.commonModule.appService.getDownloads().length == 0) {
          Row() {
            Text($r('app.string.label_downloads_empty'))
              .fontSize('14fp')
              .fontColor(Color.Gray);
          }
        }
      }
    }.linearGradient({
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