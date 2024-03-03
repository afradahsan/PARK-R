const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();

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

authRouter.get('/user', (req, res) => {
  res.json({ msg: 'afrad' })
});

module.exports = authRouter;