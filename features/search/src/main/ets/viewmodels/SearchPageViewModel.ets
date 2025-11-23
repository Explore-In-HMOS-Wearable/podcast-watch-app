import { SongModel } from 'commons/src/main/ets/models/SongModel';
import { BaseViewModel } from 'commons/src/main/ets/viewmodels/BaseViewModel';

@ObservedV2
export class SearchPageViewModel extends BaseViewModel {
  canSearch: boolean = true;

  songItemOnClick(item: SongModel) {
    this.appService.currentSong = item;

    if (this.appService.previousSearches.indexOf(item) === -1) {
      this.appService.previousSearches.push(item);
    }
    this.navigationService.pageInfos.pushPath({ name: 'Player' })
  }

  async searchOnChange(key: string) {
    if (this.canSearch) {
      this.canSearch = false;
      const future: boolean = await new Promise((resolve: Function) => {
        setTimeout(() => {
          this.appService.searchKey = key;
          this.appService.filteredSongs = this.appService.getSongsByKey(this.appService.searchKey);
          this.canSearch = true;
        }, 300);
      });
    }


  }
}