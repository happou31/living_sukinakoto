import express from "express";

const port = process.env.NODE_PORT || "3000";
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
