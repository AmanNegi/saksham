import mongoose from "mongoose";
import { Group, Message } from "../models/chat";

module.exports = function socketConfig(io: any) {
  io.on("connection", (client: any) => {
    console.log("a user is connected");

    client.on("message", async (data: any) => {
      console.log("MEsage: " + data);
      const { sender, senderName, groupId, message } = JSON.parse(data);

      console.log(sender, senderName, groupId, message);
      // convert group id to object

      const group = await Group.findOne({
        _id: new mongoose.Types.ObjectId(groupId),
      });
      console.log(groupId);

      if (!group) {
        console.log("Group not found");
        return;
      }

      group.messages.push(new Message({ sender, senderName, message }));
      await group.save();

      io.emit("message", "message received");
    });

    client.on("disconnect", () => {
      console.log("user disconnected");
    });
  });
};
