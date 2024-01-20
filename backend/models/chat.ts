import mongoose from "mongoose";

export const messageSchema = new mongoose.Schema({
  sender: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  senderName: {
    type: String,
    required: true,
  },
  message: {
    type: String,
    required: true,
  },
  images: {
    type: [String],
    default: [],
  },
  sentAt: {
    type: Date,
    default: () => {
      return new Date();
    },
  },
  priorityLevel: {
    type: String,
    enum: ["low", "medium", "high"],
    default: "low",
  },
});

export const groupSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  region: {
    type: String,
    required: true,
  },
  messages: {
    type: [messageSchema],
    default: [],
  },
});

export const Group = mongoose.model("Group", groupSchema);
export const Message = mongoose.model("Message", messageSchema);
