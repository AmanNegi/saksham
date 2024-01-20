import mongoose from "mongoose";

export const departmentSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
});

export const Department = mongoose.model("Department", departmentSchema);
