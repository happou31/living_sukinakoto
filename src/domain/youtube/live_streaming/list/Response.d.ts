export default interface ListAPIResponse {
  kind: "youtube#liveBroadcastListResponse" | "" | "";
  etag: string;
  nextPageToken: string;
  pageInfo: PageInfo;
  items: IdItem | SnippetItem | ContentDetailsItem[];
}


interface PageInfo {
  totalResults: number;
  resultsPerPage: number;
}

interface IdItem {
  kind: "youtube#liveBroadcast";
  etag: string;
  id: string;
}

interface SnippetItem {
  kind: "youtube#liveBroadcast";
  etag: string;
  id: string;

  snippet: Snippet
}


interface Snippet {
  publishedAt: string;
  channelId: string;
  title: string;
  description: string;
  thumbnails: Thumbnails;
  scheduledStartTime: string;
  actualStartTime: string;
  isDefaultBroadcast: boolean;
  liveChatId: string;
}

interface Thumbnails {
  default: ThumbnailDetail;
  medium: ThumbnailDetail;
  high: ThumbnailDetail;
  standard: ThumbnailDetail;
  maxres: ThumbnailDetail;
}

interface ThumbnailDetail {
  url: string;
  width: number;
  height: number;
}


interface ContentDetailsItem {
  kind: "youtube#liveBroadcast";
  etag: string;
  id: string;
  contentDetails: ContentDetails;
}

interface ContentDetails {
  boundStreamId: string;
  boundStreamLastUpdateTimeMs: string;
  monitorStream: MonitorStream;
  enableEmbed: boolean;
  enableDvr: boolean;
  enableContentEncryption: boolean;
  startWithSlate: boolean;
  recordFromStart: boolean;
  enableClosedCaptions: boolean;
  closedCaptionsType: string;
  enableLowLatency: boolean;
  latencyPreference: string;
  projection: string;
  enableAutoStart: boolean;
}

interface MonitorStream {
  enableMonitorStream: boolean;
  broadcastStreamDelayMs: number;
  embedHtml: string;
}
