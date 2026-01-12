export enum LoadingStatus {
  OFF = 'off',
  LOADING = 'loading',
  SUCCESS = 'success',
  FAILED = 'failed'
}

export enum WebpageStatus {
  INIT = 'init',
  ERROR = 'error',
  FINISHED = 'finished'
}

export enum ResourcesType {
  FEED = 'feed',
  ARTICLE = 'article',
  VIDEO = 'video'
}

export enum TagType {
  NORMAL = 'normal',
  RECOMMEND = 'recommend',
  HOT = 'hot'
}

/**
 * GridRow column.
 */
export enum ColumnEnum {
  SM = 4,
  MD = 8,
  LG = 12
}

/**
 * GridCol span.
 */
export enum SpanEnum {
  SM = 4,
  MD = 6,
  LG = 8
}

export enum ColSpanEnum {
  SM = 2,
  MD = 3,
  LG = 4
}

/**
 * GridCol offset.
 */
export enum OffsetEnum {
  SM = 0,
  MD = 1,
  LG = 2
}

export enum TemplateEnum {
  SM = 2,
  MD = 3,
  LG = 6
}

export enum EventTypeEnum {
  COLLECTED = 'collected_event',
  LIKED = 'liked_event',
  LEARNING = 'learning_event',
  VIEW = 'view_event',
  MINE_REFRESH= 'mine_refresh_event'
}
