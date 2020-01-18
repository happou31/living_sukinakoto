import fetch from "node-fetch";
import { OAuth2RequestParam, OAuth2ExchangeRequestParam } from "./Request";
import { AuthorizationResponse } from "./Response";

export const URL = "https://accounts.google.com/o/oauth2/auth";

export async function OAuth2Start(parameter: OAuth2RequestParam): Promise<void> {
  try {
    await fetch(
      `${URL}?clinent_id=${parameter.clientId}&redirect_uri=${parameter.redirectUri}&scope=${parameter.scope}&response_type=${parameter.responseType}&access_type=${parameter.accessType}`
    );
  } catch (e) {
    throw e;
  }

  return;
}

export async function OAuth2Exchange(parameter: OAuth2ExchangeRequestParam): Promise<AuthorizationResponse> {
  const res = await fetch(`${URL}`, {
    method: "post",
    headers: {
      Host: "accounts.google.com",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: [
      `code=${parameter.code}`,
      `client_id=${parameter.clientId}`,
      `client_secret=${parameter.clientSecret}`,
      `redirect_uri=${parameter.redirectUri}`,
      `grant_type=${parameter.grantType || "authorization_code"}`
    ]
      .map(p => encodeURIComponent(p))
      .join("&")
  });

  return res.json();
}

export async function OAuth2Authorization() {}
