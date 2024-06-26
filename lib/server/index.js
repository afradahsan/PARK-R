const express = require('express');
const authRouter = require("./routes/auth");
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');
const userRouter = require('./routes/user');
const bookingRouter = require('./routes/bookings');

const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://afradahsan02:Afrad%402061@cluster0.zxikydz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(userRouter);
app.use(bookingRouter);

mongoose.connect(DB).then(()=>{
  console.log('connection successful');
}).catch((e) => {
  console.log(e);
});

app.listen(process.env.PORT || PORT, "0.0.0.0", () => {
  console.log(`connected at ${PORT}`);
});