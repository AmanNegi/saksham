import express from "express";
import { Group } from "../models/chat";
const router = express.Router();
const { Region } = require("../models/region");

router.get("/", async (req: any, res: any) => {
  var regions = await Region.find({});
  return res.send(regions);
});

router.post("/addRegion", async (req: any, res: any) => {
  const { regionName } = req.body;
  const region = new Region({ name: regionName });
  await region.save();  
  return res.send(region);
});

router.post("/addSubRegion", async (req: any, res: any) => {
  const { regionName, subRegionName } = req.body;
  const region = await Region.findOne({ name: regionName });

  if (!region) {
    return res
      .status(404)
      .json({ error: "Region not found try /addRegion first" });
  }
  
  const subRegionGroup = await Group.findOne({ name: subRegionName });
  if (subRegionGroup) {
    return res.status(400).json({ error: "Sub region Group already exists" });
  }
  const group = new Group({ name: subRegionName, region: regionName });
  await group.save();

  region.subRegions.push({ name: subRegionName, groupId: group.id });
  await region.save();

  return res.send(region);
});

module.exports = router;
