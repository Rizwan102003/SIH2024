import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import { userPatientAuthRouter } from './Routes/userPatientAuthRouter.js';
import { userAppRouter } from './Routes/userAppRouter.js';
import { adminAppRouter } from './Routes/adminAppRouter.js';
import mongoose from 'mongoose';
const app = express();
dotenv.config({path:'secrets.env'})
app.use(cors());
app.use(express.json());
app.use(bodyParser.json());
const PORT = process.env.PORT;
console.log(PORT);
app.get('/', (req, res) => {
    res.send('Server is up and running!');
});
mongoose.connect(process.env.MONGODB_URI)
.then((res)=>{
    // console.log(res);
    console.log("Mongodb connected!");
}).catch((err)=>{
    console.log(err);
});

app.use('/auth', userPatientAuthRouter);
app.use('/app',userAppRouter);
app.use('/admin',adminAppRouter);

app.listen(PORT, ()=>{
    console.log(`Server is running on port ${PORT}`);
})
