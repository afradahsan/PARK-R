const mongoose = require('mongoose');

const vehicleSchema = mongoose.Schema({
  vehicleName: {
    type: String,
    required: true,
    trim: true
  },
  vehicleNumber: {
    type: String,
    required: true,
    trim: true
  },
  vehicleType: {
    type: String,
    required: true,
    trim: true
  }
});

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(regex);
      },
      message: 'Enter a valid Email Address'
    }
  },
  phone: {
    type: String,
    required: true,
    trim: true,
  },
  password: {
    type: String,
    required: true,
    validate: {
      validator: (value) => {
        return value.length >= 8; // Adjusted to ensure at least 8 characters
      },
      message: 'Password should be at least 8 characters long'
    }
  },
  type: {
    type: String,
    default: 'user'
  },
  vehicles: {
    type: [vehicleSchema], // Array of vehicleSchema objects
    default: []
  }
});

const User = mongoose.model('User', userSchema);
module.exports = User;
