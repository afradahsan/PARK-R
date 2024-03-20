const express = require('express');

const authRouter = require("./routes/auth");
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');

const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://afradahsan02:Afrad%402061@cluster0.zxikydz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

mongoose.connect(DB).then(()=>{
  console.log('connection successful');
}).catch((e) => {
  console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at ${PORT}`);
});