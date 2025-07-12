const path = require("path");
const express = require("express");
const expressStaticGzip = require("express-static-gzip");
const app = express();
const nocache = require("nocache");

app.use(nocache());

app.use(
  "/",
  expressStaticGzip(path.join(__dirname), {
    enableBrotli: true,
    orderPreference: ["br"],
  })
);

app.listen(9090, () => console.log("Example app is listening on port 9090."));
