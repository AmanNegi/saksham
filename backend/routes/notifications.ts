import { Notification } from "../models/notification";
const express = require("express");
const router = express.Router();
import Joi from "joi";
const objectId = require("joi-objectid")(Joi);

router.get("/getCount/:id", async (req: any, res: any) => {
  const id = req.params.id;

  if (!id) {
    return res.status(404).send("Enter a valid user id");
  }

  const notifications = await Notification.findOne({ userId: id });

  if (!notifications) {
    return res.send({ count: 0 });
  }

  const count = notifications.notifications.filter(
    (n: any) => !n.viewed
  ).length;

  return res.send({ count });
});

router.get("/:id", async (req: any, res: any) => {
  const id = req.params.id;

  const notifications = await Notification.findOne({ userId: id });

  if (!notifications) {
    return res.status(404).send("Notifications not found");
  }

  notifications.notifications.forEach((n: any) => {
    n.viewed = true;
  });
  await notifications.save();

  return res.send(notifications);
});

router.post("/add", async (req: any, res: any) => {
  const { userId, message, issueId } = req.body;

  // check if user exists by checking userId

  if (!objectId.isValid(userId)) {
    return res.status(404).json({ error: "User not found" });
  }

  if (!objectId.isValid(issueId)) {
    return res.status(404).json({ error: "Issue not found" });
  }

  // add notification to user
  const notification = await Notification.findOne({ userId });

  if (notification) {
    notification.notifications.push({
      message,
      issueId,
    });

    try {
      const savedNotification = await notification.save();
      if (!savedNotification) {
        return res
          .status(500)
          .json({ error: "Error while saving notification" });
      }
      return res.send(savedNotification);
    } catch (err) {
      return res.status(500).json({ error: "Error while saving notification" });
    }
  } else {
    const notification = new Notification({
      userId,
      notifications: [
        {
          message,
          issueId,
        },
      ],
    });

    try {
      const savedNotification = await notification.save();
      if (!savedNotification) {
        return res
          .status(500)
          .json({ error: "Error while saving notification" });
      }
      return res.send(savedNotification);
    } catch (err) {
      return res.status(500).json({ error: "Error while saving notification" });
    }
  }
});

module.exports = router;
