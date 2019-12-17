export default interface OAuth2RequestStartParam {
  client_id: string;
  redirect_uri: string;
  response_type: "code";

  scope: string;

  access_type: "online" | "offline";
}
