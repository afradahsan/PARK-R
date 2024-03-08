const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');

//SIGNUP AND SAVE DATA TO MONGODB!
authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, phone, password } = req.body;
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: 'User with the same email already existss!' })
    }

    const hashedpassword = await bcryptjs.hash(password, 8);

    let user = new User({
      name, email, phone, password: hashedpassword
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//CHECK IF THE USER ALREADY EXISTS!
authRouter.post('/api/check-user', async (req, res) => {
  const { phone } = req.body;
  try {
    const user = await User.findOne({ phone });

    if (user) {
      res.json({ existingUser: true });
    } else {
      res.json({ existingUser: false });
    }
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: 'Internal server error' });
  }
});

//SIGN IN USER
// SIGN IN USER
authRouter.post('/api/signin', async (req, res) => {
  const { phone, password } = req.body;

  console.log('Received sign-in request with phone:', phone);

  try {
    const user = await User.findOne({ phone });

    if (!user) {
      console.log(`User with ${phone} doesn't exist!`);
      return res.status(400).json({ msg: `User with ${phone} doesn't exist!` });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      console.log("Phone no. and Password don't match");
      return res.status(400).json({ msg: "Phone no. and Password don't match" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });

  } catch (e) {
    console.error('Error during sign-in:', e);
    res.status(500).json({ error: e.message });
  }
});

//LOG-OUT USER


authRouter.get('/user', (req, res) => {
  res.json({ msg: 'afrad' })
});

module.exports = authRouter;