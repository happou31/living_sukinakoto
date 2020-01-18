import express from "express";
import fs from "fs";
import { OAuth2Exchange, OAuth2Start } from "./domain/youtube/oauth/Client";

const port = process.env.NODE_PORT || "3000";
const serverUrl = `https://${process.env.DOMAIN}`;
const redirectUri = `${serverUrl}/api/authorization`;
const clientId = process.env.GCP_CLIENT_ID || "";
const clientSecret = process.env.GCP_CLIENT_SECRET || "";

const app = express();

const server = app.listen(Number.parseInt(port), () => {
  const addr = server.address();
  if (addr) {
    if (typeof addr === "string") {
      console.log(`listening to ${addr}`);
    } else {
      console.log(`listening to :${addr.port}`);
    }
  }
});

app.get("/start", async (res) => {
  console.log("start");
  await OAuth2Start({ scope: "", accessType: "online", clientId: clientId, redirectUri, responseType: "code" });
  res.header("Cache-Control: no-store");
  res.body = "start...";
});

app.get("/oauth2", async (req, res) => {
  console.log(`incoming: ${req.hostname}`);
  if (req.hostname !== "accounts.google.com") {
    res.status(401);
    return;
  }
  const code: string | undefined = req.query.code;
  if (code) {
    const authInfo = await OAuth2Exchange({
      code,
      clientId,
      clientSecret,
      redirectUri
    });

    fs.writeFileSync("./test.txt", JSON.stringify(authInfo))
  }
});
