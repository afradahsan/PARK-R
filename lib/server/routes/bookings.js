const express = require('express');
const bookingRouter = express.Router();
const Booking = require('../models/bookings');
const razorpay = require('./../services/razorpay');
const auth = require('../middleware/auth');

bookingRouter.post('/api/book-parking', async (req, res) => {
  try {
    const { user, parkingLot, startDate, endDate, startTime, endTime, vehicleNumber, qrCodeData, status, paymentStatus, totalPrice } = req.body;

    //CREATE RAZORPAY ORDER!
    const razorpayOrder = await razorpay.orders.create({
      amount: totalPrice * 100,
      currency: 'INR',
    });

    const newBooking = new Booking({
      user,
      parkingLot,
      startDate,
      endDate,
      startTime,
      endTime,
      vehicleNumber,
      qrCodeData,
      status,
      paymentStatus,
      totalPrice,
      razorpayId: razorpayOrder.id,
    });

    const savedBooking = await newBooking.save();

    res.status(201).json(savedBooking);
  } catch (e) {
    console.error('Error booking parking:', e);
    res.status(500).json({ error: 'An error occurred while booking parking' });
  }
});

bookingRouter.get('/api/get-booking', auth, async (req, res) => {
  try {
    const userId = req.user;

    const bookings = await Booking.find({ user: userId }).populate('parkingLot');

    res.json(bookings);
  } catch (e) {
    console.error('Error fetching bookings:', e);
    res.status(500).json({ error: 'An error occurred while fetching bookings' });
  }
});

bookingRouter.post('/api/delete-parking', async (req, res) => {
  try {
    const { id } = req.body;

    let booking = await Booking.findByIdAndDelete(id);

    res.json(booking);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

bookingRouter.get('/api/get-booking/:parkingLotId', auth, async (req, res) => {
  try {
    const parkingLotId = req.params.parkingLotId;
    const bookings = await Booking.find({ parkingLot: parkingLotId }).populate('parkingLot');
    res.json(bookings);
  } catch (e) {
    console.error('Error fetching bookings:', e);
    res.status(500).json({ error: 'An error occurred while fetching bookings' });
  }
});




module.exports = bookingRouter;