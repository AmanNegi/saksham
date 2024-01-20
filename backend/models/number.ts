import mongoose from "mongoose";

/*
{
  regionId,
  subRegions: [
    numbers: [
      {
       departmentId,
       number,
      },
    ]
  ]
}
*/

const regionNumberSchema = new mongoose.Schema({
  number: {
    type: String,
    required: true,
  },
  departmentId: {
    type: String,
    required: true,
  },
});

export const numberSchema = new mongoose.Schema({
  numbers: {
    type: [regionNumberSchema],
    required: true,
  },
  regionId: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
});

export const Number = mongoose.model("Number", numberSchema);
