import { CommonColors } from '../constants/CommonColors';
import { CommonFloats } from '../constants/CommonFloats';
import { CommonMedia } from '../constants/CommonMedia';
import { CommonStrings } from '../constants/CommonStrings';
import { AppService } from '../services/AppService';
import { AudioService } from '../services/AudioService';
import { NavigationService } from '../services/NavigationService';


export class CommonModule {
  static _instance: CommonModule;

  static getInstance() {
    if (!CommonModule._instance) {
      CommonModule._instance = new CommonModule();
    }
    return CommonModule._instance;
  }


  commonColors: CommonColors = new CommonColors();
  commonMedia: CommonMedia = new CommonMedia();
  commonStrings: CommonStrings = new CommonStrings();
  commonFloats: CommonFloats = new CommonFloats();


  private _appService?: AppService;

  get appService(): AppService {
    if (!this._appService) {
      this._appService = AppService.getInstance();
    }
    return this._appService;
  }

  private _audioService?: AudioService;

  get audioService(): AudioService {
    if (!this._audioService) {
      this._audioService = AudioService.getInstance();
    }
    return this._audioService;
  }

  private _navigationService?: NavigationService;

  get navigationService(): NavigationService {
    if (!this._navigationService) {
      this._navigationService = NavigationService.getInstance();
    }
    return this._navigationService;
  }
}
