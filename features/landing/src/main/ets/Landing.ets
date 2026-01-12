import { IndexViewModel } from './LandingViewModel';
import { ArcList,ArcListAttribute,ArcListItemAttribute, ArcListItem, ComponentContent } from '@kit.ArkUI';
import { CommonModule } from 'commons';
import { SongModel } from 'commons/src/main/ets/models/SongModel';

@Builder
function buildText() {
  Column() {
    Text('Podcast')
      .fontSize('23fp')
      .fontColor(Color.White);
    Text('x.y.zz.t1')
      .fontSize('10fp')
      .fontColor(Color.White)
  }
  .justifyContent(FlexAlign.Center)
  .margin({ top: 15 })
}

export class TmpClass {
  podcasts: SongModel[] = []
  listName: string = ''

  constructor(podcasts: SongModel[], listName: string) {
    this.podcasts = podcasts;
    this.listName = listName;
  }
}

@Entry
@Component
export struct Landing {
  pageInfos: NavPathStack = new NavPathStack();
  context: UIContext = this.getUIContext();
  header: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));
  indexVm: IndexViewModel = new IndexViewModel();
  commonModule: CommonModule = CommonModule.getInstance();

  navigateToRelatedPageClick(route: string): void {
    this.commonModule.navigationService.pageInfos.pushPath({ name: route })
  }

  build() {

    NavDestination() {

      ArcList({
        initialIndex: 0,
        header: this.header
      }) {

        //MainList
        ArcListItem() {
          Row() {
            Text($r('app.string.label_mainlist'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            this.commonModule.navigationService.pageInfos.pushPathByName('MainListPage',
              new TmpClass(this.commonModule.appService.getAllSongs(), 'My Podcasts'))
          })
        }
        .width('90%')
        .margin({ bottom: 10 })


        //Play From
        ArcListItem() {
          Column() {
            Row() {
              Text($r('app.string.label_play_from'))
                .fontSize($r('app.float.menu_item_font_size'))
                .fontColor(Color.White)

              Row() {
                Image($r('app.media.watch'))
                  .width(25)
                  .height(25)
                  .fillColor(this.indexVm.playFromWatch ? $r('app.color.button_color') : Color.White)
                  .margin({ right: 16 })
                  .onClick(() => {
                    this.indexVm.playFromChange(true);
                  });
                Column()
                  .backgroundColor(Color.Grey)
                  .width(1)
                  .height(20)

                Image($r('app.media.phone'))
                  .width(25)
                  .height(25)
                  .fillColor(this.indexVm.playFromWatch ? Color.White : $r('app.color.button_color'))
                  .margin({ left: 16 })
                  .onClick(() => {
                    this.indexVm.playFromChange(false);
                  });
              }
              .justifyContent(FlexAlign.SpaceEvenly)
              .alignItems(VerticalAlign.Center)

            }
            .padding({
              left: 12,
              bottom: 12,
              top: 12,
              right: 12
            })
            .backgroundColor($r('app.color.menu_item_background'))
            .width('90%')
            .height('60vp')
            .borderRadius(48)
            .justifyContent(FlexAlign.SpaceBetween)
          }.backgroundColor(Color.Transparent)
        }
        .width('90%')
        .margin({ bottom: 0 });

        //Warning Text
        ArcListItem() {
          if (!this.indexVm.playFromWatch) {
            Text($r('app.string.label_play_from_watch_warning'))
              .fontSize($r('app.float.warning_font_size'))
              .fontColor(Color.Red)
          }
        }
        .width('90%')
        .margin({ bottom: 10, top: 2 });


        //Search
        ArcListItem() {
          Row() {
            Text($r('app.string.label_discover'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            this.navigateToRelatedPageClick('GenresPage')
          })
        }
        .width('90%')
        .margin({ bottom: 10 })


        //Search
        ArcListItem() {
          Row() {
            Text($r('app.string.label_search'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            this.navigateToRelatedPageClick('SearchPage')
          })
        }
        .width('90%')
        .margin({ bottom: 10 })


        ArcListItem() {
          Row() {
            Text($r('app.string.label_settings'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            this.navigateToRelatedPageClick('Settings')
          })
        }
        .width('90%')
        .margin({ bottom: 10 });


        //Offline Mode
        ArcListItem() {
          Row() {
            Text($r('app.string.label_offline_mode'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)

            Toggle({ type: ToggleType.Switch, isOn: false }).onChange((value: boolean) => {
              this.indexVm.offLineModeChange(value);
            })
              .margin(0)
              .width('80vp')
              .scale({ x: 0.9, y: 0.9 })
          }
          .padding({
            left: 12,
            bottom: 12,
            top: 12,
            right: 12
          })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('90%')
        .margin({ bottom: 10 })

        //Downloads
        ArcListItem() {
          Row() {
            Text($r('app.string.label_downloads'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
        }
        .width('90%')
        .margin({ bottom: 10 })
        .onClick(() => {
          this.navigateToRelatedPageClick('Downloads')
        })

        //Favorites
        ArcListItem() {
          Row() {
            Text($r('app.string.label_favorites'))
              .fontSize($r('app.float.menu_item_font_size'))
              .fontColor(Color.White)
          }
          .padding({ left: 12, bottom: 12, top: 12 })
          .backgroundColor($r('app.color.menu_item_background'))
          .width('90%')
          .height('45vp')
          .borderRadius(48)
          .justifyContent(FlexAlign.Start)
        }
        .width('90%')
        .margin({ bottom: 10 })
        .onClick(() => {
          this.navigateToRelatedPageClick('Favorites')
        })

      }
      .borderRadius('466px')
      .scrollBar(BarState.Off)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
      .height('100%')
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[$r('app.color.base_background_gradient_start'), 0.0],
          [$r('app.color.base_background_gradient_end'), 1],]
      })
      .gesture(
        PanGesture()
          .onActionStart((event: GestureEvent) => {
            if (event.offsetX > 10) {
              return true
            }
            return false
          })
      )

    }

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })

  }
}