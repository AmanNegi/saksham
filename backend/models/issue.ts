import mongoose from "mongoose";
import Joi, { object } from "joi";
const objectId = require("joi-objectid")(Joi);

export const issueSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: String,
  status: {
    type: String,
    enum: ["open", "closed", "stale", "in-progress"],
    default: "open",
  },
  createdAt: {
    type: Date,
    default: () => {
      return new Date();
    },
    //TODO: Update such that issue expires in 48 hours
    // expires: 1_72_800,
    // Currently setting it to 64 hours for testing purposes
  },
  department: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  location: {
    type: {
      type: String,
      enum: ["Point"],
      default: "Point",
    },
    coordinates: {
      type: [Number],
      required: true,
    },
  },
  images: {
    type: [String],
  },
  issuedBy: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
  },
});

export function validateCreateInput(body: any) {
  const schema = Joi.object().keys({
    title: Joi.string().required(),
    status: Joi.string().valid("open", "closed").default("open"),
    description: Joi.string().required(),
    department: objectId().required(),
    location: Joi.object()
      .keys({
        type: Joi.string().valid("Point").default("Point"),
        coordinates: Joi.array().items(Joi.number()).required(),
      })
      .required(),
    images: Joi.array().items(Joi.string()),
    issuedBy: objectId().required(),
  });

  return schema.validate(body);
}
export function validateResolveInput(body: any) {
  const schema = Joi.object().keys({
    issueId: objectId().required(),
    userId: objectId().required(),
  });

  return schema.validate(body);
}

export const Issue = mongoose.model("Issue", issueSchema);
