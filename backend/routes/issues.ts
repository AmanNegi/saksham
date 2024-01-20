import express from "express";
const router = express.Router();
import {
  Issue,
  validateCreateInput,
  validateResolveInput,
} from "../models/issue";
import { User } from "../models/user";
import Joi from "joi";
import { Department } from "../models/department";
const objectId = require("joi-objectid")(Joi);

router.get("/", async (req: any, res: any) => {
  return res.send("/api/issues working!");
});

router.post("/create", async (req: any, res: any) => {
  console.log(req.body);
  const { error } = validateCreateInput(req.body);

  if (error) {
    return res.status(400).json(error.details[0].message);
  }

  const { issuedBy, title, description, department, location, images } =
    req.body;

  // check if user exists by checking issuedBy
  const user = await User.findById(issuedBy);
  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  // check if user has already lodged a request in the department
  const existingIssue = await Issue.findOne({
    issuedBy,
    department,
    status: "open",
  });

  if (existingIssue) {
    return res
      .status(400)
      .json({ error: "You already have an open issue in this department" });
  }

  const issue = new Issue({
    title,
    description,
    department,
    location,
    images,
    issuedBy,
  });

  try {
    const savedUser = await issue.save();
    if (!savedUser) {
      return res.status(500).json({ error: "Error while saving issue" });
    }
    return res.status(200).json(savedUser);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.post("/resolve/:status", async (req: any, res: any) => {
  const status = req.params.status;

  if (status !== "closed" && status !== "stale") {
    return res.status(400).json({ error: "Invalid status" });
  }

  const { error } = validateResolveInput(req.body);
  if (error) {
    return res.status(400).json(error.details[0].message);
  }

  const { issueId, userId } = req.body;

  // check if user exists by checking userId
  const user = await User.findOne({ _id: userId });
  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  // check if issue exists by checking issueId
  const issue = await Issue.findOne({ _id: issueId });
  if (!issue) {
    return res.status(404).json({ error: "Issue not found" });
  }

  try {
    issue.status = status;
    await issue.save();
    return res.status(200).json(issue);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.put("/update/:id", async (req: any, res: any) => {
  const { error } = validateCreateInput(req.body);
  if (error) {
    return res.status(400).json(error.details[0].message);
  }
  const { id } = req.params;
  const { issuedBy, title, description, department, location, images } =
    req.body;

  // check if user exists by checking issuedBy
  const user = await User.findById(issuedBy);
  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  try {
    const issue = await Issue.findById(id);
    if (!issue) {
      return res.status(404).json({ error: "Issue not found" });
    }

    issue.title = title;
    issue.description = description;
    issue.department = department;
    issue.location = location;
    issue.images = images;

    const updatedIssue = await issue.save();
    return res.status(200).json(updatedIssue);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.get("/list/:id", async (req: any, res: any) => {
  const { id } = req.params;

  const { error } = objectId().validate(id);
  if (error) {
    return res.status(400).json(error.details[0].message);
  }

  const user = await User.findById(id);
  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  try {
    const issues = await Issue.find({ issuedBy: id });

    let response;
    // fill in department for each issue

    response = await Promise.all(
      issues.map(async (issue: any) => {
        const department = await Department.findOne({ _id: issue.department });
        if (!department) {
          return res.status(404).json({ error: "Department not found" });
        }

        return {
          ...issue._doc,
          issuedBy: user.name,
          departmentName: department.name,
        };
      })
    );

    console.log(response);

    return res.status(200).json(response);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.get("/department/list/:id", async (req: any, res: any) => {
  const { id } = req.params;
  console.log(id);

  const { error } = objectId().validate(id);

  if (error) {
    return res.status(400).json(error.details[0].message);
  }

  const issues = await Issue.find({ department: id, status: "open" });
  console.log(issues);

  let response;
  // fill in department for each issue

  response = await Promise.all(
    issues.map(async (issue: any) => {
      const department = await Department.findOne({ _id: issue.department });
      if (!department) {
        return res.status(404).json({ error: "Department not found" });
      }

      const user = await User.findOne({ _id: issue.issuedBy });
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      return {
        ...issue._doc,
        issuedBy: user!.name,
        departmentName: department.name,
      };
    })
  );

  return res.send(response);
});

module.exports = router;
