import express from "express";
import { Department } from "../models/department";
const router = express.Router();

router.get("/", async (req: any, res: any) => {
  try {
    const departments = await Department.find({}, { __v: 0 });
    return res.send(departments);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.post("/", async (req: any, res: any) => {
  const { name } = req.body;
  try {
    const department = new Department({ name });
    await department.save();
    return res.send(department);
  } catch (err) {
    return res.status(500).json(err);
  }
});

module.exports = router;
