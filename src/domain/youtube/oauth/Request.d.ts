export interface OAuth2RequestParam {
  clientId: string;
  redirectUri: string;
  responseType: "code";

  scope: string;

  accessType: "online" | "offline";
}

export interface OAuth2ExchangeRequestParam {
  code: string;
  clientId: string;
  clientSecret: string;

  redirectUri: string;

  grantType?: string;
}
