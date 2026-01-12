import { CommonModule } from 'commons';
import { AudioStatus } from 'commons/src/main/ets/services/AudioService';
import { PlayerViewModel } from '../viewmodels/PlayerViewModel';
import { UIContext } from '@kit.ArkUI';

@Component
export struct PlayerPage {
  playerVm: PlayerViewModel = new PlayerViewModel();
  commonModule: CommonModule = CommonModule.getInstance();
  pageInfos: NavPathStack = new NavPathStack();
  @State rotateAngle: number = 0
  @State words: string[] = [];
  @State currentWordIndex: number = -1;
  @State isStarted: boolean = false;
  timer: number = 0;
  yoffset: number = -55;
  velocity: number = 1.6
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.words = this.playerVm.appService.text.split(' ');
    this.currentWordIndex = -1;

    this.playerVm.audioService.audioStatus = AudioStatus.Undefined
  }

  startReading() {
    if (this.isStarted) {
      return;
    }

    this.isStarted = true;
    this.currentWordIndex = 0;

    this.timer = setInterval(() => {
      if (this.currentWordIndex < this.words.length - 1) {
        this.scrollToCurrentWord();
      } else {
        clearInterval(this.timer);
        this.isStarted = false;
        UIContext.prototype.getPromptAction().showToast({ message: 'Read Completed!' });
      }
    }, 300);
  }

  stopReading() {
    clearInterval(this.timer);
    this.isStarted = false;
  }

  scrollToCurrentWord() {

    this.scroller.scrollTo({
      xOffset: 0,
      yOffset: (this.yoffset += this.velocity) < 0 ? 0 : this.yoffset += this.velocity,
      animation: {
        duration: 300,
        curve: Curve.EaseOut
      }
    });
  }

  private rotatePage() {

    this.getUIContext()?.animateTo({
      duration: 500,
      curve: Curve.EaseInOut
    }, () => {
      this.rotateAngle += 180;
    })

  }

  build() {

    NavDestination() {

      Stack() {
        Image(this.playerVm.appService.currentSong.songPic)
          .width('100%')
          .height('100%')
          .borderRadius(100)
          .objectFit(ImageFit.Cover)
          .backgroundColor(Color.Green)
          .onClick(() => {

            if (this.playerVm.appService.currentSong.isInList) {
              this.rotatePage();
            }

          })

        Stack() {

          if ((this.rotateAngle % 360) < 90 || (this.rotateAngle % 360) > 270) {

            Column() {
              Row() {
                Row() {
                  Image(this.playerVm.appService.currentSong.isFavorite ? this.commonModule.commonMedia.filledFav :
                    this.commonModule.commonMedia.fav)
                    .width(25)
                    .height(25)
                    .fillColor(this.playerVm.appService.currentSong.isFavorite ?
                      this.commonModule.commonColors.buttonColor :
                      Color.White)
                    .onClick(() => {
                      this.playerVm.changeFavStatus(this.playerVm.appService.currentSong);
                    })
                }.justifyContent(FlexAlign.Center).width(50);

                Column() {
                  //Author
                  Text(this.playerVm.appService.currentSong.songName)
                    .fontSize('14fp')
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .margin({ top: 10 });

                  //Song
                  Text(this.playerVm.appService.currentSong.songAuthor)
                    .fontSize('14fp')
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Color.White)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .alignRules({
                      center: { anchor: '__container__', align: VerticalAlign.Center },
                      middle: { anchor: '__container__', align: HorizontalAlign.Center }
                    })
                    .margin({ top: 4, bottom: 10 });
                }.alignItems(HorizontalAlign.Center)
                .margin({ right: 10, left: 10 })
                .width('50%')

                Row() {
                  Image(this.playerVm.appService.currentSong.isDownloaded ? this.commonModule.commonMedia.downloads :
                    this.commonModule.commonMedia.download)
                    .width(this.playerVm.appService.currentSong.isDownloaded ? 30 : 25)
                    .height(this.playerVm.appService.currentSong.isDownloaded ? 30 : 25)
                    .fillColor(this.playerVm.appService.currentSong.isDownloaded ?
                      this.commonModule.commonColors.buttonColor : Color.White)
                    .onClick(() => {
                      this.playerVm.changeDownloadStatus(this.playerVm.appService.currentSong);
                    })
                }.justifyContent(FlexAlign.Center).width(50);

              }.justifyContent(FlexAlign.Center)

              Column() {
                Row() {
                  Image(this.commonModule.commonMedia.previous)
                    .width(40)
                    .height(40)
                    .fillColor(Color.White)
                    .margin({ right: 20 })
                    .onClick(() => {
                      this.playerVm.previousSong();
                    });

                  Row() {
                    Gauge({ value: this.commonModule.audioService.progress, min: 0, max: 100 }) {
                      Image(this.playerVm.audioService.audioStatus === AudioStatus.Playing ?
                        this.commonModule.commonMedia.pause :
                        this.commonModule.commonMedia.start)
                        .width(40)
                        .height(40)
                        .fillColor(Color.White)
                        .margin(8)
                        .onClick(async () => {
                          if (this.playerVm.audioService.audioStatus === AudioStatus.Paused) {
                            this.playerVm.resumeAudio();
                            this.startReading()
                          } else if (this.playerVm.audioService.audioStatus !== AudioStatus.Playing) {
                            await this.playerVm.startAudio(this.commonModule.appService.currentSong);
                            this.startReading()
                          } else {
                            this.playerVm.pauseAudio();
                            this.stopReading()
                          }
                        });
                    }
                    .colors($r('app.color.gauge_color'))
                    .width(60)
                    .height(60)
                    .indicator(null)
                    .strokeWidth(6)
                    .value(this.playerVm.audioService.progress)
                  }

                  Image(this.commonModule.commonMedia.next)
                    .width(40)
                    .height(40)
                    .fillColor(Color.White)
                    .margin({ left: 20 })
                    .onClick(() => {
                      this.playerVm.nextSong();
                    });

                }
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center);
              }
              .margin({ bottom: 30 })

            }
            .backgroundColor('#B3B0B0B0')
            .width('100%')
            .borderRadius(48)
            .position({ bottom: 0 })
            .linearGradient({
              direction: GradientDirection.Bottom,
              colors: [['#801E90FF', 0.0],
                ['#80666666', 1],]
            })

          } else if (this.playerVm.appService.currentSong.isInList) {

            Column() {

              Button('Back')
                .type(ButtonType.Capsule)
                .fontSize(11)
                .height('9%')
                .width('100vp')
                .onClick(() => {

                  this.rotatePage();

                })
                .margin({ top: 3 })


              Scroll(this.scroller) {

                Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
                  Text('    ').visibility(Visibility.Hidden)
                  ForEach(this.words, (word: string, idx: number) => {
                    Text(word + ` `)
                      .fontSize(12)
                      .padding(3)
                      .borderRadius(5)
                      .id(`word_${idx}`)

                  }, (item: string, index: number) => item)

                }
                .margin({
                  bottom: 0,
                  top: 0,
                  left: 19,
                  right: 19
                })

              }
              .height('84%')
              .scrollable(ScrollDirection.Vertical)
              .scrollBar(BarState.Auto)
              .edgeEffect(EdgeEffect.Spring)

            }
            .width('100%')
            .backgroundColor(Color.Black)
            .height('100%')
            .align(Alignment.Center)
            .rotate({
              x: 0,
              y: 1,
              z: 0,
              angle: 180
            })
          }
        }
        .rotate({
          x: 0,
          y: 1,
          z: 0,
          angle: this.rotateAngle
        })
        .animation({ duration: 500, curve: Curve.EaseInOut })

      }
      .gesture(
        PanGesture()
          .onActionStart((event: GestureEvent) => {
            if (event.offsetX < 13) {
              this.playerVm.audioService.stop()
              this.playerVm.audioService.audioStatus = AudioStatus.Paused
              this.stopReading()
              this.commonModule.navigationService.pageInfos.pushPath({ name: 'Landing' })

              return true
            }
            return false
          })
      )
      .height('100%')
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[this.commonModule.commonColors.baseBackgroundGradientStart, 0.0],
          [this.commonModule.commonColors.baseBackgroundGradientEnd, 1],]
      })
      .backgroundColor(Color.Black);

    }

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })
  }
}