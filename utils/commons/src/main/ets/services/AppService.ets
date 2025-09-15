import { SongModel } from '../models/SongModel';

@ObservedV2
export class AppService {
  static _instance: AppService;
  @Trace currentSong: SongModel = SongModel.empty();
  previousSearches: SongModel[] = [];
  @Trace searchPageReloadCount: number = 0;
  @Trace filteredSongs: SongModel[] = [];
  @Trace searchKey: string = '';
  @Trace showReloadButton: boolean = false;
  @Trace mockSongs: SongModel[] = [
    new SongModel('Podcast Huawei', 'Harmony Next Series 1', 'podcast_huaweiwatch.mp3', $r('app.media.watch_background'), false, false, true),
    new SongModel('Podcast Huawei', 'Harmony Next Series 2', 'podcast_huaweiwatch.mp3', $r('app.media.watch_background'), false, false, true),
    new SongModel('Podcast Huawei', 'Harmony Next Series 3', 'podcast_huaweiwatch.mp3', $r('app.media.watch_background'), false, false, true),
    new SongModel('AI Ethics: Fairness & Bias', 'Curious Minds', 'ep001_ai_ethics_fairness_bias.mp3', $r('app.media.1'), false, false, false),
    new SongModel('Quantum Computing Basics', 'FutureCast', 'ep002_quantum_computing_basics.mp3', $r('app.media.2'), false, false, false),
    new SongModel('Missions to Mars and Space Exploration', 'Orbit Notes', 'ep003_mars_missions_space_exploration.mp3', $r('app.media.3'), false, false, false),
    new SongModel('Climate Adaptation Strategies', 'Planet Now', 'ep004_climate_adaptation_strategies.mp3', $r('app.media.1'), false, false, false),
    new SongModel('Solar Energy 101', 'Green Grid', 'ep005_solar_energy_101.mp3', $r('app.media.2'), false, false, false),
    new SongModel('Blockchain Beyond Crypto', 'Ledger Lines', 'ep006_blockchain_beyond_crypto.mp3', $r('app.media.3'), false, false, false),
    new SongModel('Zero-Trust Cybersecurity', 'Secure Byte', 'ep007_zero_trust_cybersecurity.mp3', $r('app.media.1'), false, false, false),
    new SongModel('Data Privacy and GDPR', 'Data Dialogues', 'ep008_data_privacy_gdpr.mp3', $r('app.media.2'), false, false, false)

  ];
  @Trace text: string =
    'Hello everyone, it\'s Jude here and you\'re welcome to SmartWatchSeries. So following' +
      ' the last update a month ago, the Huawei Watch D2 is now receiving a new software update.' +
      ' This software update has a firmware version number of 5.1.0.18 and it upgrades the operating' +
      ' system from Harmony OS 5.0 to Harmony OS 5.1. It also brings new features to the Watch D2.' +
      ' This firmware update has a file size of 92.99MB, so downloading it will be quick.Looking at' +
      ' the changelog, the first addition says, adds the new hex grid layout. With a swipe from the' +
      ' top to the bottom, you can show or hide app names while freely switching between hex' +
      ' grid, grid and list display layouts. Secondly, this update introduces new watch faces' +
      ' to the D2. This includes transparent landscape, maximum module, color cutout, speedway,' +
      ' chronograph and galactic watch faces. This of course gives you more ways to express your' +
      ' style.Lastly, this update adds average sleep heart rate variability monitoring to the Watch' +
      ' D2 so that you can track how well you slept and how well you recovered from fatigue and stress.' +
      ' This feature will also monitor your heart rate, respiratory rate and blood oxygen while you sleep' +
      ' to establish a psychological baseline and provide timely health alerts. Heart rate variability is a' +
      ' natural beat-to-beat variation in your heart\'s rhythm.It is the variation between two consecutive' +
      ' beats, and it reflects the balance of your autonomic nervous system.'

  getDownloads(): SongModel[] {
    const returnValue = this.mockSongs.filter((value: SongModel, index: number, array: SongModel[]): boolean => {
      return value.isDownloaded;
    });
    return returnValue;
  }

  getFavorites(): SongModel[] {
    const returnValue = this.mockSongs.filter((value: SongModel, index: number, array: SongModel[]): boolean => {
      return value.isFavorite;
    });
    return returnValue;
  }

  getAllSongs(): SongModel[] {
    const allInList = this.mockSongs.filter(s => Boolean(s.isInList));
    return allInList
  }

  getAllPotentialSongs(): SongModel[] {
    const allInList = this.mockSongs.filter(s => Boolean(!s.isInList));
    return allInList
  }

  getSongsByKey(searchKey: string): SongModel[] {
    const key = searchKey.toLowerCase().trim();

    const filtered = this.mockSongs.filter((value: SongModel) => {
      return value.songName.toLowerCase().includes(key) || value.songAuthor.toLowerCase().includes(key);
    });


    const itemsPerPage = 3;
    const startIndex = this.searchPageReloadCount * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;

    const sliced = filtered.slice(startIndex, endIndex);

    if (filtered.length > 3 && sliced.length == 3) {
      this.showReloadButton = true;
    } else {
      this.showReloadButton = false;
    }

    return sliced;
  }

  reloadOnClick() {
    this.searchPageReloadCount = this.searchPageReloadCount + 1;
    this.filteredSongs = this.getSongsByKey(this.searchKey)
  }


  static getInstance() {
    if (!AppService._instance) {
      AppService._instance = new AppService();
    }
    return AppService._instance;
  }
}