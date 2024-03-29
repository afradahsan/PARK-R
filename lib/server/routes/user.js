const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const User = require("../models/user");
const { ObjectId } = require('mongodb');

userRouter.post('/api/add-vehicles', auth, async (req, res) => {
  try {
    console.log('add-vehicles route handler called');

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
    console.error('Error in add-vehicles route handler:', e.message);
    res.status(500).json({ error: e.message });
  }
});

userRouter.get('/api/get-vehicles', auth, async (req, res) => {
  try {
    // Retrieve the authenticated user's ID from the request
    const userId = req.user;

    // Find the user in the database based on their ID
    const user = await User.findById(userId);

    // If the user is found, return their vehicles
    if (user) {
      const vehicles = user.vehicles;
      res.json(vehicles);
    } else {
      // If the user is not found, return a 404 Not Found error
      res.status(404).json({ error: 'User not found' });
    }
  } catch (e) {
    // Handle any errors that occur during the process
    console.error('Error in get-vehicles route handler:', e.message);
    res.status(500).json({ error: e.message });
  }
});

userRouter.post('/api/edit-vehicles', auth, async (req, res) => {
  try {
    console.log('edit-vehicles route handler called');

    // Inside the route handler
    const { vehicleId, vehicleName, vehicleNumber, vehicleType } = req.body;
    console.log(vehicleId);

    // Convert the vehicleId string to an ObjectId
    const objectIdVehicleId = new ObjectId(vehicleId);

    const user = await User.findById(req.user);

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Find the index of the vehicle using the converted ObjectId
    const vehicleIndex = user.vehicles.findIndex(vehicle => vehicle._id.equals(objectIdVehicleId));

    if (vehicleIndex === -1) {
      return res.status(404).json({ error: 'Vehicle not found' });
    }

    user.vehicles[vehicleIndex].vehicleName = vehicleName;
    user.vehicles[vehicleIndex].vehicleNumber = vehicleNumber;
    user.vehicles[vehicleIndex].vehicleType = vehicleType;

    const updatedUser = await user.save();

    res.json(updatedUser);

  } catch (e) {
    console.error('Error in edit-vehicles route handler:', e.message);
    res.status(500).json({ error: e.message });
  }
});

userRouter.post('/api/delete-vehicle', auth, async (req, res) => {
  try {
    const { id } = req.body; // Ensure vehicleId is correctly extracted from the request body
    console.log(id); // Check if vehicleId is logged correctly

    const objectIdVehicleId = new ObjectId(id);
    console.log(objectIdVehicleId);

    const user = await User.findById(req.user);
    console.log(user);
    console.log('hello');
    if (!user) {
      return res.status(404).json({ error: 'User not found'});
    }

    const vehicleIndex = user.vehicles.findIndex(vehicle => vehicle._id.equals(objectIdVehicleId));
    
    if (vehicleIndex === -1) {
      return res.status(404).json({ error: 'Vehicle not found' });
    }

    user.vehicles.splice(vehicleIndex, 1);

    await user.save();

    res.json({ message: 'Vehicle deleted successfully' });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;