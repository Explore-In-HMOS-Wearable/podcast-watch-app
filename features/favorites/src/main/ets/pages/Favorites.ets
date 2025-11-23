import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent } from '@kit.ArkUI';
import { CommonModule } from 'commons';
import { SongModel } from 'commons/src/main/ets/models/SongModel';
import { FavoritesViewModel } from '../viewmodels/FavoritesViewModel';

@Component
export struct Favorites {
  favoritesVm: FavoritesViewModel = new FavoritesViewModel()
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
              .fontColor(Color.Gray).maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis });
          }.alignItems(HorizontalAlign.Start).width('40%')
        }

        Image(this.commonModule.appService.currentSong.isFavorite ? $r('app.media.filled_fav') : $r('app.media.fav'))
          .width(25)
          .height(25)
          .margin({ right: 10 })
          .fillColor(this.commonModule.appService.currentSong.isFavorite ? $r('app.color.button_color') : Color.White)
          .onClick(() => {
            this.favoritesVm.changeFavStatus(item);
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

      ForEach(this.commonModule.appService.getFavorites(), (item: SongModel, index: number) => {
        this.songListItem(item);
      }, (item: SongModel) => item.songName)

      ArcListItem() {
        if (this.commonModule.appService.getFavorites().length === 0) {
          Row() {
            Text($r('app.string.label_favorites_empty'))
              .fontSize('14fp')
              .fontColor(Color.Gray);
          }
        }
      }
    }.linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[$r('app.color.base_background_gradient_start'), 0.0],
        [$r('app.color.base_background_gradient_end'), 1]]
    })

    }

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })

  }



}