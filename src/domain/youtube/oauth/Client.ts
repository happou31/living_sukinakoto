import fetch from "node-fetch";
import OAuth2RequestParam from "./Request";

export const URL = "https://accounts.google.com/o/oauth2/auth";

export async function OAuth2Start(parameter: OAuth2RequestParam) {
  try {
    await fetch(
      `{${URL}}?clinent_id=${parameter.client_id}&redirect_uri=${parameter.redirect_uri}&scope=${parameter.scope}&response_type=${parameter.response_type}&access_type=${parameter.access_type}`
    );
  } catch (e) {}
}

export async function OAuth2Exchange(code: string) {}

export async function OAuth2Authorization() {}
