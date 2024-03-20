const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const Parking = require('../models/parking');

//ADD PARKING LOT.
adminRouter.post('/admin/add-parking', admin, async (req, res) => {
  try {
    console.log('postingg');
    const { image, parkingName, locationName, position, parkingFee, totalSpots, indoor, carWash, evCharge } = req.body;

    let parking = new Parking({
      image,
      parkingName, 
      locationName, 
      position, 
      parkingFee, 
      totalSpots, 
      indoor, 
      carWash, 
      evCharge
    });
    parking = await parking.save();
    res.json(parking);
  } catch (e) {
    res.status(500).json({ e: e.message });
  }
});

//FETCH PARKING
adminRouter.get('/admin/get-parking', async (req, res) => {
  try {
    const parkingLots = await Parking.find({});
    res.json(parkingLots);
  } catch (e) {
    res.status(500).json({error: e.message});
  }
})

module.exports = adminRouter;