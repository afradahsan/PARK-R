const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const Parking = require('../models/parking');

//ADD PARKING LOT.
adminRouter.post('/admin/add-parking', admin, async (req, res) => {
  try {
    console.log('postingg');
    const { image, parkingName, locationName, position, carparkingFee, bikeparkingFee, truckparkingFee, carwashFee, bikewashFee, totalSpots, availSpots, indoor, carWash, evCharge, approved, userId } = req.body;

    let parking = new Parking({
      image,
      parkingName, 
      locationName, 
      position, 
      carparkingFee,
      bikeparkingFee,
      truckparkingFee,
      carwashFee,
      bikewashFee,
      totalSpots,
      availSpots,
      indoor, 
      carWash, 
      evCharge,
      approved,
      userId
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
});

adminRouter.post('/admin/edit-parking/:id', admin, async (req, res) => {
  try {
    const { id } = req.params;
    const { image, parkingName, locationName, position, carparkingFee, bikeparkingFee, truckparkingFee, carwashFee, totalSpots, indoor, carWash, evCharge } = req.body;

    let parking = await Parking.findById(id);
    
    if (!parking) {
      return res.status(404).json({ error: "Parking lot not found" });
    }

    parking.image = image;
    parking.parkingName = parkingName;
    parking.locationName = locationName;
    parking.position = position;
    parking.carparkingFee = carparkingFee;
    parking.bikeparkingFee = bikeparkingFee;
    parking.truckparkingFee = truckparkingFee;
    parking.carwashFee = carwashFee;
    parking.totalSpots = totalSpots;
    parking.indoor = indoor;
    parking.carWash = carWash;
    parking.evCharge = evCharge;

    // Save the updated parking lot
    parking = await parking.save();
    
    res.json(parking);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get('/admin/get-parking/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const parkingLot = await Parking.findById(id);
    if (!parkingLot) {
      return res.status(404).json({ error: "Parking lot not found" });
    }
    res.json(parkingLot);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post('/admin/delete-parking', async (req, res) => {
  try {
    const {id} = req.body;
    
    let parking = await Parking.findByIdAndDelete(id);
    res.json(parking);

  } catch (e) {
    res.status(500).json({error: e.message});
  }
});

module.exports = adminRouter;