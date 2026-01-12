import { curves } from '@kit.ArkUI';
import { CommonModule } from 'commons';

@Builder
export function SplashPageBuilder(name: string, param: Object) {
  Splash()
}

@Component
export struct Splash {
  pageInfos: NavPathStack = new NavPathStack();
  commonModule: CommonModule = CommonModule.getInstance();
  private timerId = 0;
  @State imageTranslateY: number = 300;
  @State textOffsetY: number = -50;
  @State textOpacity: number = 0;
  @State isVisible: boolean = false

  aboutToAppear() {
    setTimeout(() => {
      this.textOffsetY = 0;
      this.textOpacity = 1;
    }, 100);

    setTimeout(() => {
      this.imageTranslateY = 10;
    }, 300);

    setTimeout(() => {
      this.isVisible = true
    }, 300)

    this.timerId = setTimeout(() => {

      this.commonModule.navigationService.pageInfos.replaceDestination({ name: 'Landing' })

    }, 2000);
  }

  onDestroy() {
    if (this.timerId) {
      clearTimeout(this.timerId);
    }
  }

  build() {

    NavDestination() {

      Stack() {
        Column() {
          Text('Dive into the Largest Universe of Podcasts')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .translate({ y: this.textOffsetY })
            .opacity(this.textOpacity)
            .width('70%')
            .animation({
              curve: curves.initCurve(),
              iterations: 1,
              duration: 800,
              playMode: PlayMode.Normal
            })

          Image($r('app.media.podcasts'))
            .height('25%')
            .translate({ y: this.imageTranslateY })
            .animation({
              curve: curves.initCurve(),
              iterations: 1,
              duration: 700,
              playMode: PlayMode.Normal
            })

          Blank().height('10%')

          Text('All in One Place!')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .translate({ y: this.isVisible ? 0 : 200 })
            .opacity(this.isVisible ? 1 : 0)
            .animation({
              duration: 1100,
              curve: Curve.EaseOut
            })

        }
        .align(Alignment.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)

    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })
  }
}
