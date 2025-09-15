import { Settings } from 'settings';
import { CommonModule } from 'commons';
import { PlayerPage } from 'player';
import { SearchPage } from 'search';
import { Downloads } from 'downloads';
import { Favorites } from 'favorites';
import { Landing } from 'landing';
import { GenresPage } from 'genres';
import { Splash } from 'splash';
import { MainList } from 'mainlist';

@Entry
@Component
struct NavigationRouter {
  commonModule: CommonModule = CommonModule.getInstance();

  aboutToAppear() {
    this.commonModule.navigationService.pageInfos.pushPath({ name: 'Splash' })
  }

  @Builder
  routeMap(builderName: string, param: object) {
    if (builderName === 'Settings') {
      Settings();
    } else if (builderName === 'Splash') {
      Splash();
    } else if (builderName === 'Landing') {
      Landing();
    } else if (builderName === 'Genres') {
      GenresPage();
    } else if (builderName === 'MainListPage') {
      MainList({
        podcasts: this.commonModule.appService.getAllSongs(),
        listName: 'My Podcasts'
      });
    } else if (builderName === 'SearchPage') {
      SearchPage();
    } else if (builderName === 'Player') {
      PlayerPage();
    } else if (builderName === 'Downloads') {
      Downloads();
    } else if (builderName === 'Favorites') {
      Favorites();
    }
  }

  build() {
    Navigation(this.commonModule.navigationService.pageInfos) {
    }
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')

  }
}