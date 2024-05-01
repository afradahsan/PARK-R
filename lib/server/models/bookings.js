const mongoose = require('mongoose');

const bookingSchema = mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'users', 
    required: true
  },
  parkingLot: {
    type: String,
    required: true
  },
  startDate: {
    type: String,
    required: true
  },
  endDate: {
    type: String,
    required: true
  },
  startTime: {
    type: String,
    required: true
  },
  endTime: {
    type: String,
    required: true
  },
  vehicleNumber: {
    type: String,
    required: true
  },
  qrCodeData: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['pending', 'confirmed', 'cancelled'],
    default: 'pending'
  },
  paymentStatus: {
    type: String,
    enum: ['unpaid', 'paid'],
    default: 'unpaid'
  },
  totalPrice: {
    type: Number,
    required: true
  },
  razorpayId: {
    type: String,
    required: true
  }
});

const Booking = mongoose.model('Booking', bookingSchema);

module.exports = Booking;