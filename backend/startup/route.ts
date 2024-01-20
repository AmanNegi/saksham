const auth = require("../routes/auth");
const issue = require("../routes/issues");
const department = require("../routes/department");
const regions = require("../routes/regions");

module.exports = function (app: any) {
  app.use("/api/auth", auth);
};
