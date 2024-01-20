import express from "express";
import mongoose, { ObjectId } from "mongoose";
import { Department } from "../models/department";
const router = express.Router();
const { Region } = require("../models/region");

router.post("/add", async (req: any, res: any) => {
  const { regionId, subRegionId, departmentId, number } = req.body;

  const region = await Region.findOne({ _id: regionId });
  console.log(region);

  if (!region) {
    return res.status(404).json({ error: "Region not found" });
  }

  const department = await Department.findOne({ _id: departmentId });

  if (!department) {
    return res.status(404).json({ error: "Department not found" });
  }

  // find subRegion with subRegionId
  for (let subRegion of region.subRegions) {
    if (subRegion._id.toString() === subRegionId) {
      // find number with departmentId
      const deptNumber = subRegion.numbers.find(
        (n: any) => n.departmentId === departmentId
      );

      if (deptNumber) {
        deptNumber.number = number;
        console.log("Updated Department Number");
        await region.save();
        return res.send(region);
      }

      subRegion.numbers.push({
        number,
        departmentId,
        departmentName: department.name,
      });

      await region.save();
      return res.send(region);
    }
  }
  return res.status(404).json({ error: "Sub region not found" });
});

router.get("/:regionId", async (req: any, res: any) => {
  const { regionId } = req.params;

  if (!mongoose.Types.ObjectId.isValid(regionId)) {
    return res.status(400).json({ error: "Invalid regionId" });
  }

  const region = await Region.find({ _id: regionId });

  if (!region) {
    return res.status(404).json({ error: "No numbers found" });
  }

  return res.send(region);
});

module.exports = router;
