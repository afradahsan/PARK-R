const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true
  },
  email: {
    required: true,
    type: String,
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
    required: true,
    type: String,
    trim: true,
  },
  password: {
    required: true,
    type: String,
    validator: (value) => {
      return value.length > 8;
    },
    message: 'Password should be atleast 8 characters'
  },
  type: {
    type: String,
    default: 'user'
  }
});

const User = mongoose.model("User", userSchema);
module.exports = User;