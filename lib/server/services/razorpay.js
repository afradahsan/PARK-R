const razorpay = require('razorpay');

const instance = new razorpay({
  key_id: 'rzp_test_JOthFkpJyGOCeW',
  key_secret: '3VYGC2EyUdKeEbnQ1oVK9LMz'
});

module.exports = instance;