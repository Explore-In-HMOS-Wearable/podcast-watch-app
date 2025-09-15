export class SettingsMenuModel {
  public menuText: string;
  public menuSubText: string;
  public onTap: VoidCallback;

  constructor(menuText: string, menuSubText: string, onTap: VoidCallback) {
    this.menuText = menuText;
    this.menuSubText = menuSubText;
    this.onTap = onTap;

  }

  static empty() {
    return new SettingsMenuModel('', '', () => {
    })
  }
}