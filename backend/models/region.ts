import mongoose from "mongoose";

export const subRegionSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  groupId: {
    type: String,
    required: true,
  },
  numbers: {
    type: [
      {
        departmentId: {
          type: String,
          required: true,
        },
        departmentName: {
          type: String,
          required: true,
        },
        number: {
          type: String,
          required: true,
        },
      },
    ],
    default: [],
  },
});

export const regionSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  subRegions: {
    type: [subRegionSchema],
    required: true,
  },
});

export const Region = mongoose.model("Region", regionSchema);
