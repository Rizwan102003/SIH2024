import express from 'express';
import axios from 'axios';
import bcrypt from 'bcrypt';
import mongoose from 'mongoose';
import jwt from 'jsonwebtoken';
import { extractUserId } from '../Middlewares/middleware.js'
import { userPatientAuthModel } from '../Models/userPatientAuthModel.js'
const router = express.Router();

router.post('/signup', async (req, res) => {
    try {
        const { username, email, password, fullName, height, weight, bloodType, lastCheckUpDoctor, lastCheckUpDate } = req.body;
        console.log(username, email, password, fullName, height, weight, bloodType, lastCheckUpDoctor, lastCheckUpDate);

        const alreadyExists = await userPatientAuthModel.findOne({ 'userDetails.email': email  });
        if (alreadyExists) {
            return res.json({ status: false, message: "User already exists!" });
        }

        if (!username || !email || !password || !fullName || !height || !weight || !bloodType || !lastCheckUpDoctor || !lastCheckUpDate) {
            return res.json({ message: 'Please include all the mandatory fields!', status: false });
        }
        if (username.length <5 || username.length > 10) {
            return res.json({ message: 'Please enter username between 5 and 10 characters!', status: false });
        }
        if (password.length < 8 || password.length >= 16) {
            return res.json({ message: 'Please ensure password length is between 8 and 16 characters.', status: false });
        }
        if (typeof (fullName) !== 'string') {
            return res.json({ message: 'Please ensure full name is of type string', status: false })
        }
        const hashPassword = await bcrypt.hash(password, 10);
        

        const newPatient = new userPatientAuthModel({
            userDetails: {
                username: username,
                email: email,
                password: hashPassword,
                fullName: fullName
            },
            healthDetails: {
                height: height,
                weight: weight,
                bloodType: bloodType,
                bloodType: bloodType,
                lastCheckUp: {
                    lastCheckUpDoctor: lastCheckUpDoctor,
                    lastCheckUpDate: lastCheckUpDate
                }
            }
        });
        await newPatient.save();
        const patientCollectionName = `patient_${newPatient._id}`;
        await mongoose.connection.db.createCollection(patientCollectionName);
        return res.json({ message: 'Your Registration was successful!' });
    }
    catch (err) {
        console.log(err.message);
        return res.json({ message: err.message, status: true });
    };
});

router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    if(!email || !password){
        return res.json({ message: 'Please provide email and password!', status: false });
    }

    const patientExists = await userPatientAuthModel.findOne({'userDetails.email':email});

    if(!patientExists){
        return res.json({ message: 'Invalid email or password!', status: false });
    }
    const patientPassword = await bcrypt.compare(password, patientExists.userDetails.password);

    if(!patientPassword)
    {
        return res.json({ message: 'Invalid email or password!', status: false });
    }
    const token = jwt.sign(
        { userId: patientExists._id, email: patientExists.userDetails.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' , httpOnly: true}
    );

    return res.json({ message: 'Login successful!', status: true, token: token });

});

router.get('/profile/:token', async (req, res) => {
    const { token } = req.params;
    if(!token)
    {
        return res.json({ message: 'Authentication token not provided!', status: false });
    }
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    console.log(decodedToken);
    const patient = await userPatientAuthModel.findById(decodedToken.userId);
    if(!patient)
    {
        return res.json({ message: 'Patient not found!', status: false });
    }

    res.json({message:'profile Sent!', status:true, profile:{
        username: patient.userDetails.username,
        email: patient.userDetails.email,
        fullName: patient.userDetails.fullName,
        height: patient.healthDetails.height,
        weight: patient.healthDetails.weight,
        bloodType: patient.healthDetails.bloodType,
        lastCheckUpDoctor: patient.healthDetails.lastCheckUp.lastCheckUpDoctor,
        lastCheckUpDate: patient.healthDetails.lastCheckUp.lastCheckUpDate
    }});
})

router.post('/updateProfile/:token', async (req, res) => {
    const { username, fullName, height, weight, bloodType, lastCheckUpDoctor, lastCheckUpDate } = req.body;

})

router.post('/deleteProfile', async (req, res) => {


});

router.post('/uploadfiles', async (req, res) => {
    
    
});

router.get('/logout', async (req, res) => {
    
    
});

//Chatbot endpoint to query for user lifestyle suggestions.

router.post('/ai/suggestions', async (req, res) => {

})

router.post('/ai/symptoms', async (req, res) => {

});

export { router as userPatientAuthRouter };