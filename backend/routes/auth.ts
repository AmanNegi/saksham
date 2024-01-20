import express from "express";
const router = express.Router();
import { User, validateLogin, validateSignUp } from "../models/user";
import _ from "lodash";

router.get("/", async (req: any, res: any) => {
  try {
    const users = await User.find({}, { password: 0, __v: 0 });
    return res.send(users);
  } catch (err) {
    return res.status(500).json(err);
  }
});

router.post("/login", (req: any, res: any) => {
  const { error } = validateLogin(req.body);

  if (error) {
    return res.status(400).json(error.details[0].message);
  }
  const { phone, password } = req.body;

  // find any user with phone
  User.findOne({ phone })
    .then((user) => {
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      // compare password
      if (user.password !== password) {
        return res.status(401).json({ error: "Invalid Password" });
      }

      // return user
      return res.status(200).json(_.omit(user.toObject(), ["password", "__v"]));
    })
    .catch((err: any) => {
      return res.status(500).json(err);
    });
});

router.post("/signUp", async (req: any, res: any) => {
  const { error } = validateSignUp(req.body);

  if (error) {
    return res.status(400).json(error.details[0].message);
  }

  const { name, phone, password, userType } = req.body;
  const user = new User(
    {
      name,
      phone,
      password,
      userType,
    },
    { password: 0, __v: 0 }
  );

  const e = await User.findOne({ phone: phone });
  console.log(e);
  if (e != null) {
    return res.status(400).json({ error: "User already exists" });
  }

  user
    .save()
    .then((user: any) => {
      return res.status(200).json(user);
    })
    .catch((err: any) => {
      return res.status(500).json(err);
    });
});

module.exports = router;
