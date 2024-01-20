import Joi from "joi";
import mongoose from "mongoose";

export const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
    unique: true,
    min: 10,
    max: 10,
  },
  password: {
    type: String,
    required: true,
    min: 6,
  },
  userType: {
    type: String,
    enum: ["user", "admin"],
    default: "user",
  },
  createdAt: {
    type: Date,
    default: () => {
      return new Date();
    },
  },
});

export function validateLogin(body: any) {
  const schema = Joi.object().keys({
    phone: Joi.string().min(10).max(10).required(),
    password: Joi.string().min(6).required(),
  });

  return schema.validate(body);
}

export function validateSignUp(body: any) {
  const schema = Joi.object().keys({
    name: Joi.string().required(),
    userType: Joi.string().valid("user", "admin").default("user"),
    phone: Joi.string().min(10).max(10).required(),
    password: Joi.string().min(6).required(),
  });

  return schema.validate(body);
}

export const User = mongoose.model("User", userSchema);
