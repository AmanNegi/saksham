import mongoose from "mongoose";

const notificationSchema = new mongoose.Schema({
  viewed: {
    type: Boolean,
    default: false,
  },
  message: {
    type: String,
    required: true,
  },
  addedAt: {
    type: Date,
    default: () => {
      return new Date();
    },
  },
  issueId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
});

export const notificationsSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  notifications: {
    type: [notificationSchema],
  },
});

export const Notifications = mongoose.model(
  "Notification",
  notificationsSchema
);
