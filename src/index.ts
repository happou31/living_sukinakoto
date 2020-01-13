import express from "express";

const app = express();

const server = app.listen(3000, () => {
  const addr = server.address();
  if (addr) {
    if (typeof addr === "string") {
      console.log(`listening to ${addr}`);
    } else {
      console.log(`listening to :${addr.port}`);
    }
  }
});
