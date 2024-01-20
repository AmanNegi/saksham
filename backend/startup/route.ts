const auth = require("../routes/auth");
const issue = require("../routes/issues");
const department = require("../routes/department");
const regions = require("../routes/regions");
const chat = require("../routes/chat");
const number = require("../routes/numbers");
const notifications = require("../routes/notifications");

module.exports = function (app: any) {
  app.use("/api/auth", auth);
  app.use("/api/issues", issue);
  app.use("/api/departments", department);
  app.use("/api/regions", regions);
  app.use("/api/chat", chat);
  app.use("/api/number", number);
  app.use("/api/notifications", notifications);
};
