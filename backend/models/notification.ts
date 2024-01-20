import mongoose from "mongoose";

export const notificationsSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
  notifications: {
    type: [
      {
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
      },
    ],
  },
});

export const Notification = mongoose.model("Notification", notificationsSchema);
