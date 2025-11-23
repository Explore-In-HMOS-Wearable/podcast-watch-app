@ObservedV2
export class IndexViewModel {
  @Trace playFromWatch: boolean = true;
  @Trace offlineMode: boolean = false;

  async playFromChange(playFromWatch: boolean) {
    if (playFromWatch !== this.playFromWatch) {
      this.playFromWatch = playFromWatch

      if (playFromWatch === false) {
        const result: boolean = await new Promise((resolve: Function) => {
          setTimeout(() => {
            resolve(true);
          }, 3000);
        });
        this.playFromWatch = result;
      }
    }
  }

  offLineModeChange(value: boolean) {
    if (value) {
      this.offlineMode = true
    } else {
      this.offlineMode = false
    }
  }
}