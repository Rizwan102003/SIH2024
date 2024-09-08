import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import { userPatientAuthRouter } from './Routes/userPatientAuthRouter.js';
import { userAppRouter } from './Routes/userAppRouter.js';
import { userAdminAuthRouter } from './Routes/userAdminAuthRouter.js';
import { userDoctorAuthRouter } from './Routes/userDoctorAuthRouter.js';

const app = express();
dotenv.config({path:'secrets.env'});
app.use(cors());
app.use(express.json());
app.use(bodyParser.json());
const PORT = process.env.PORT;
console.log(PORT);
mongoose.connect(process.env.MONGODB_URI)
.then((res)=>{
    // console.log(res);
    console.log("Mongodb connected!");
}).catch((err)=>{
    console.log(err.message);
});

app.use('/patientAuth', userPatientAuthRouter);
app.use('/doctorAuth', userDoctorAuthRouter);
app.use('/app',userAppRouter);
app.use('/adminAuth',userAdminAuthRouter);

app.listen(PORT, ()=>{
    console.log(`Server is running on port ${PORT}`);
});
