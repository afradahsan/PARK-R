const mongoose = require('mongoose');

const parkingSchema = mongoose.Schema({
  parkingName: {
    type: String,
    required: true,
    trim: true
  },
  locationName: {
    type: String,
    required: true,
    trim: true,
  },
  image: {
    type: String,
    required: true,
  },
  position: {
    type: String,
    required: true,
  },
  totalSpots: {
    type: Number,
    required: true,
  },
  carparkingFee: {
    type: Number,
    required: true,
  },
  bikeparkingFee: {
    type: Number,
    required: true,
  },
  truckparkingFee: {
    type: Number,
    required: true,
  },
  carwashFee: {
    type: Number,
    required: true,
  },
  indoor: {
    type: Boolean,
    required: true,
  },
  evCharge: {
    type: Boolean,
    required: true,
  },
  carWash: {
    type: Boolean,
    required: true,
  },
  approved: {
    type: Boolean,
    default: false
  }
});

const parking = mongoose.model('Parking', parkingSchema);
module.exports = parking;