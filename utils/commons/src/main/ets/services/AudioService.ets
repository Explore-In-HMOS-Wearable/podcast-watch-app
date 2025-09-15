import { media } from '@kit.MediaKit';
import { audio } from '@kit.AudioKit';
import { common } from '@kit.AbilityKit';


export
enum AudioStatus {
  Undefined,
  Playing,
  Paused,
  Released,
}

@ObservedV2
export class AudioService {
  static _instance: AudioService;


  // Ensure only one instance of this ViewModel is created
  static getInstance() {
    if (!AudioService._instance) {
      AudioService._instance = new AudioService(AudioStatus.Undefined);
    }
    return AudioService._instance;
  }

  constructor(audioStatus: AudioStatus) {
    this.audioStatus = audioStatus;
  }


  private player: media.AVPlayer | undefined;
  @Trace audioStatus: AudioStatus;
  private progressTimer: number | undefined;
  @Trace progress: number = 0;

  private startProgressUpdater() {
    this.clearProgressUpdater(); // Clear any existing timer
    this.progressTimer = setInterval(() => {
      this.progress = this.getCurrentProgressPercentage();
      console.log(`Progress: ${this.progress}%`);
      // You can also notify the UI here via state or event if needed
    }, 1000); // update every second
  }

  private clearProgressUpdater() {
    if (this.progressTimer !== undefined) {
      clearInterval(this.progressTimer);
      this.progressTimer = undefined;
    }
  }


  public getCurrentProgressPercentage(): number {
    if (!this.player || this.player.duration === 0) {
      return 0;
    }

    const currentSeconds = this.player.currentTime / 1_000_000;
    const totalSeconds = this.player.duration / 1_000_000;

    return Math.floor((currentSeconds / totalSeconds) * 100);
  }

  setCallbacks(avPlayer: media.AVPlayer) {
    avPlayer.on('stateChange', async (state: string) => {
      console.info('AVPlayer state:', state);
      switch (state) {
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0,
          };
          avPlayer.prepare();
          break;
        case 'prepared':
          this.audioStatus = AudioStatus.Playing
          avPlayer.play();
          this.startProgressUpdater();
          break;
        case 'completed':
          this.audioStatus = AudioStatus.Released
          this.progress = 100;
          avPlayer.stop();
          this.clearProgressUpdater();
          break;
        case 'stopped':
          avPlayer.reset();
          this.clearProgressUpdater();
          break;
        case 'pause':
          avPlayer.pause();
          break;
      }
    });

    avPlayer.on('error', (err) => {
      console.error('AVPlayer error:', err.message);
      avPlayer.reset();
    });
  }

  public async playEmbeddedMp3(fileName: string) {
    this.release();
    const context = getContext(this) as common.UIAbilityContext;
    const resourceFd = await context.resourceManager.getRawFd(fileName);

    const avFileDescriptor: media.AVFileDescriptor = {
      fd: resourceFd.fd,
      offset: resourceFd.offset,
      length: resourceFd.length,
    };
    this.player = await media.createAVPlayer();
    this.setCallbacks(this.player);
    this.player.fdSrc = avFileDescriptor;
  }

  public pause() {
    this.audioStatus = AudioStatus.Paused
    this.player?.pause();
  }

  public resume() {
    this.audioStatus = AudioStatus.Playing
    this.player?.play();
  }

  public stop() {
    this.audioStatus = AudioStatus.Released
    this.player?.stop();
  }

  public release() {
    this.audioStatus = AudioStatus.Released
    this.player?.reset();
    this.clearProgressUpdater();
  }
}
