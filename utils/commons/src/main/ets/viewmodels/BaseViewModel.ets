import { AppService } from '../services/AppService';
import { AudioService } from '../services/AudioService';
import { NavigationService } from '../services/NavigationService';
import { SongModel } from '../models/SongModel';


@ObservedV2
export class BaseViewModel {
  audioService: AudioService = AudioService.getInstance();
  appService: AppService = AppService.getInstance()
  navigationService: NavigationService = NavigationService.getInstance();

  changeFavStatus(item: SongModel) {
    const currentIndex = this.appService.mockSongs.indexOf(item);
    this.appService.mockSongs[currentIndex].isFavorite = !this.appService.mockSongs[currentIndex].isFavorite;
  }

  changeDownloadStatus(item: SongModel) {
    const currentIndex = this.appService.mockSongs.indexOf(item);
    this.appService.mockSongs[currentIndex].isDownloaded = !this.appService.mockSongs[currentIndex].isDownloaded;
  }

}