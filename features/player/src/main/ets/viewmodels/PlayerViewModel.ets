import { BaseViewModel, CommonModule } from 'commons';
import { SongModel } from 'commons/src/main/ets/models/SongModel';
import { AppService } from 'commons/src/main/ets/services/AppService';


@ObservedV2
export class PlayerViewModel extends BaseViewModel {
  appService: AppService = CommonModule.getInstance().appService;

  resumeAudio() {
    this.audioService.resume();
  }

  async startAudio(songModel: SongModel) {
    await this.audioService.playEmbeddedMp3(songModel.songPath);
  }

  stopAudio() {
    this.audioService.stop();
  }

  pauseAudio() {
    this.audioService.pause();
  }

  nextSong() {
    const currentIndex = this.appService.mockSongs.indexOf(this.appService.currentSong);
    const targetIndex: number = currentIndex + 1;
    const isNextAvailable: boolean = currentIndex < AppService.getInstance().mockSongs.length - 1;

    if (isNextAvailable) {
      this.appService.currentSong = this.appService.mockSongs[targetIndex];
      this.audioService.playEmbeddedMp3(this.appService.mockSongs[targetIndex].songPath);
    }
  }

  previousSong() {
    const currentIndex: number = this.appService.mockSongs.indexOf(this.appService.currentSong);
    const targetIndex: number = currentIndex - 1;
    const isPreviousAvailable: boolean = currentIndex > 0

    if (isPreviousAvailable) {
      this.appService.currentSong = this.appService.mockSongs[targetIndex];
      this.audioService.playEmbeddedMp3(this.appService.mockSongs[targetIndex].songPath);
    }
  }
}
