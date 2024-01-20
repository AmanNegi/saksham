const auth = require("../routes/auth");
const issue = require("../routes/issues");
const department = require("../routes/department");
const regions = require("../routes/regions");

module.exports = function (app: any) {
  app.use("/api/auth", auth);
  app.use("/api/department", department);
  app.use("/api/issues", issue);
  app.use("/api/regions", regions);
};
