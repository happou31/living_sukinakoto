import * as Base from "../../Base";

export default interface GetParam {
  part: Base.PartRequestParam;
  broadcastStatus?: "active" | "all" | "completed" | "upcoming";
  id?: string;

  mime?: boolean;

  broadcastType?: "all" | "event" | "persistent";

  maxResult?: number;

  onBehalfOfContentOwner?: string;

  onBehalfOfContentOwnerChannel?: string;

  pageToken?: string;
}
