import { Group, Message } from "../models/chat";
const express = require("express");
const router = express.Router();

router.get("/:id", async (req: any, res: any) => {
  const id = req.params.id;
  const group = await Group.findOne({ _id: id });

  return res.send(group);
});

router.post("/sendMessage/:id", async (req: any, res: any) => {
  const id = req.params.id;
  const group = await Group.findOne({ _id: id });

  if (!group) {
    return res.status(404).send("Group not found");
  }

  const { sender, senderName, message, priorityLevel, images } = req.body;
  const msg = new Message({
    sender,
    senderName,
    message,
    priorityLevel: priorityLevel || "low",
    images: images || [],
  });

  group.messages.push(msg);
  await group.save();

  return res.send(group);
});

module.exports = router;
