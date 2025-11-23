import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent } from '@kit.ArkUI';
import { SettingsMenuModel } from 'commons/src/main/ets/models/SettingsMenuModel';
import { CommonModule } from 'commons';

@Builder
function buildText() {
  Column() {
    Text(CommonModule.getInstance().commonStrings.labelSettings)
      .fontSize('18fp')
      .fontColor(CommonModule.getInstance().commonColors.buttonColor);
  }
  .justifyContent(FlexAlign.Center)
  .margin({ top: 10, bottom: 10 })
}


class MenuDataSource implements IDataSource {
  private list: SettingsMenuModel[];
  private listeners: DataChangeListener[] = [];

  constructor(list: SettingsMenuModel[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): SettingsMenuModel {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listeners.push(listener);
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    this.listeners = this.listeners.filter(l => l !== listener);
  }
}

@Component
export struct Settings {
  pageInfos: NavPathStack = new NavPathStack();

  context: UIContext = this.getUIContext();
  header: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));
  //Would like to add volume.
  menuList: SettingsMenuModel[] = [
    new SettingsMenuModel('Account', '', () => {
      // Navigate to account settings
    }),
    new SettingsMenuModel('Playback', '', () => {
      // Navigate to playback settings
    }),
    new SettingsMenuModel('Sound Quality', 'Currently: Standard', () => {
      // Quality settings
    }),
    new SettingsMenuModel('Volume Control', '', () => {
      // Volume adjustment
    }),
    new SettingsMenuModel('Auto-Download', 'Wi-Fi Only', () => {
      // Download preferences
    }),
    new SettingsMenuModel('Storage Management', '1.2GB used', () => {
      // Storage settings
    }),
    new SettingsMenuModel('Equalizer', 'Preset: Balanced', () => {
      // EQ settings
    }),
    new SettingsMenuModel('Sleep Timer', 'Off', () => {
      // Timer settings
    }),
    new SettingsMenuModel('Crossfade', '0 seconds', () => {
      // Crossfade settings
    }),
    new SettingsMenuModel('Lyrics Display', 'Enabled', () => {
      // Lyrics settings
    }),
    new SettingsMenuModel('Device Sync', 'Last sync: 2h ago', () => {
      // Sync settings
    }),
    new SettingsMenuModel('Notifications', 'Enabled', () => {
      // Notification settings
    }),
    new SettingsMenuModel('Delete All Downloads', '', () => {
      // Clear downloads
    }),
    new SettingsMenuModel('App Version', '0.0.12.1', () => {
      // Version info
    }),
    new SettingsMenuModel('Sign Out', '', () => {
      // Sign out
    }),
    new SettingsMenuModel('Reset App', '', () => {
      // Reset to defaults
    })
  ]
  commonModule: CommonModule = CommonModule.getInstance();
  private menuDataSource: MenuDataSource = new MenuDataSource(this.menuList);


  @Builder
  menuItem(model: SettingsMenuModel) {
    //Downloads
    ArcListItem() {
      Column() {
        Text(model.menuText)
          .fontSize(this.commonModule.commonFloats.MENU_ITEM_FONT_SIZE)
          .fontColor(Color.White);
        Text(model.menuSubText)
          .fontSize('10fp')
          .fontColor(Color.Gray)
      }
      .padding({ left: 12, bottom: 12, top: 12 })
      .backgroundColor(this.commonModule.commonColors.menuItemBackground)
      .width('90%')
      .height('90px')
      .borderRadius(48)
      .justifyContent(FlexAlign.Start)
    }
    .width('90%')
    .margin({ bottom: 10 })
  }

  build() {

    NavDestination() {

      ArcList({
      initialIndex: 1,
      header: this.header
    }) {
      LazyForEach(this.menuDataSource, (item: SettingsMenuModel, index: number) => {
        this.menuItem(item);
      })
    }
    .scrollBar(BarState.Off)
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .height('100%')
    .width('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[this.commonModule.commonColors.baseBackgroundGradientStart, 0.0],
        [this.commonModule.commonColors.baseBackgroundGradientEnd, 1]]
    })

    }

    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

    })

  }
}