const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const User = require("../models/user");

userRouter.post('/api/add-vehicles', auth, async (req, res) => {
  try {
    const { vehicleName, vehicleNumber, vehicleType } = req.body;

    const user = await User.findById(req.user);

    const newVehicle = {
      vehicleName: vehicleName,
      vehicleNumber: vehicleNumber,
      vehicleType: vehicleType
    };

    user.vehicles.push(newVehicle);

    const updatedUser = await user.save();

    res.json(updatedUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
