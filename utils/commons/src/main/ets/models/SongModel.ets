import { CommonModule } from '../components/CommonModule';

@ObservedV2
export class SongModel {
  @Trace public songName: string;
  @Trace public songAuthor: string;
  @Trace public songPath: string;
  @Trace public songPic: Resource;
  @Trace public isFavorite: boolean;
  @Trace public isDownloaded: boolean;
  @Trace public isInList: boolean;

  constructor(songName: string, songAuthor: string, songPath: string, songPic: Resource, isFavorite: boolean,
    isDownloaded: boolean, isInList: boolean) {
    this.songName = songName;
    this.songAuthor = songAuthor;
    this.songPath = songPath;
    this.songPic = songPic;
    this.isFavorite = isFavorite;
    this.isDownloaded = isDownloaded;
    this.isInList = isInList;
  }

  static empty() {
    return new SongModel('', '', '', CommonModule.getInstance().commonMedia.background, false, false, false)
  }
}

export class TmpClass {
  podcasts: SongModel[] = []
  listName: string = ''
  isMainList: boolean=true

  constructor(podcasts: SongModel[], listName: string,isMainList: boolean) {
    this.podcasts = podcasts;
    this.listName = listName;
    this.isMainList = isMainList;
  }
}
