import express from 'express';
import axios from 'axios';
import bcrypt from 'bcrypt';
import mongoose from 'mongoose';
import jwt from 'jsonwebtoken';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import { extractUserId } from '../Middlewares/middleware.js'
import { userPatientAuthModel } from '../Models/userPatientAuthModel.js'
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
import { promisify } from 'util';

const router = express.Router();
const readdir = promisify(fs.readdir);

router.post('/signup', async (req, res) => {
    console.log("Signup route called!")
    try {
        const {username,  email, password, } = req.body;
        // console.log(username, email, password, fullName, height, weight, bloodType, lastCheckUpDoctor, lastCheckUpDate);

        const alreadyExists = await userPatientAuthModel.findOne({ 'userDetails.email': email });
        if (alreadyExists) {
            return res.json({ status: false, message: "User already exists!" });
        }

        if ( !email || !password ) {
            return res.json({ message: 'Please include all the mandatory fields!', status: false });
        }
    
        if (password.length < 8 || password.length >= 16) {
            return res.json({ message: 'Please ensure password length is between 8 and 16 characters.', status: false });
        }
        const hashPassword = await bcrypt.hash(password, 10);

        const newPatient = new userPatientAuthModel({
            userDetails: {
                email: email,
                password: hashPassword,
            },
        });

        await newPatient.save();

        const  patientCollectionName = `patient_${newPatient._id}`;
        await mongoose.connection.db.createCollection(patientCollectionName);
        // Create a new folder for the patient
        // const patientFolderPath = path.join(__dirname, 'uploadedFiles', 'patient', `${username}_${newPatient._id}`);
        try {
            const patientFolderPath = path.join('./', `uploadedFiles/patient/${username}_${newPatient._id}`);
            if (!fs.existsSync(patientFolderPath)) {
                fs.mkdirSync(patientFolderPath, { recursive: true });
                console.log("File created!")
            }
        }
        catch (err) {
            console.error(err);
            return res.json({ message: 'Error creating patient folder!', status: false });
        }

        return res.json({ message: 'Your Registration was successful!', status: true });
    }
    catch (err) {
        console.log(err.message);
        return res.json({ message: err.message, status: false });
    }
});

router.post('/login', async (req, res) => {
    console.log("Login route called!")
    const { email, password } = req.body;
    if (!email || !password) {
        return res.json({ message: 'Please provide email and password!', status: false });
    }

    const patientExists = await userPatientAuthModel.findOne({ 'userDetails.email': email });

    if (!patientExists) {
        return res.json({ message: 'Invalid email or password! Please Signup first!', status: false });
    }
    const patientPassword = await bcrypt.compare(password, patientExists.userDetails.password);

    if (!patientPassword) {
        return res.json({ message: 'Invalid email or password!', status: false });
    }
    const token = jwt.sign(
        { userId: patientExists._id, email: patientExists.userDetails.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
    );

    return res.json({ message: 'Login successful!', status: true, token: token });

});

router.get('/profile/:token', async (req, res) => {
    const { token } = req.params;
    if (!token) {
        return res.json({ message: 'Please login!', status: false });
    }
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    console.log(decodedToken);
    const patient = await userPatientAuthModel.findById(decodedToken.userId);
    if (!patient) {
        return res.json({ message: 'Patient not found!', status: false });
    }

    res.json({
        message: 'profile Sent!', status: true, profile: {
            username: patient.userDetails.username,
            email: patient.userDetails.email,
            fullName: patient.userDetails.fullName,
            height: patient.healthDetails.height,
            weight: patient.healthDetails.weight,
            bloodType: patient.healthDetails.bloodType,
            lastCheckUpDoctor: patient.healthDetails.lastCheckUp.lastCheckUpDoctor,
            lastCheckUpDate: patient.healthDetails.lastCheckUp.lastCheckUpDate
        }
    });
});

router.post('/updateProfile/:token', async (req, res) => {
    console.log("Update profile route called!")
    try {
        const { username, height, weight, lastCheckUpDoctor, lastCheckUpDate, chronicIllness, allergies } = req.body;

        const { token } = req.params;
        console.log(token)
        if (!token) {
            return res.json({ message: "Please login!", status: false });
        }
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decodedToken);

        await userPatientAuthModel.findByIdAndUpdate(decodedToken.userId, {
            userDetails: {
                username: username,
            },
            healthDetails: {
                height: height,
                weight: weight,
                chronicIllness: chronicIllness,
                allergies: allergies,
                lastCheckUp: {
                    lastCheckUpDoctor: lastCheckUpDoctor,
                    lastCheckUpDate: lastCheckUpDate
                }
            }
        });
        res.json({ message: "Profile updated successfully!", status: true });
    }
    catch (err) {
        console.log(err.message);
        res.json({ message: err.message, status: false });
    }
});

router.get('/deleteProfile/:token', async (req, res) => {
    try {
        const { token } = req.params;
        if (!token) {
            return res.json({ message: "Please login!", status: false });
        }
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
        await userPatientAuthModel.findByIdAndDelete(decodedToken.userId);
        const patientCollectionName = `patient_${decodedToken.userId}`;
        await mongoose.connection.db.dropCollection(patientCollectionName);
        res.json({ message: "Profile deleted successfully!", status: true });
    }
    catch (err) {
        console.log(err.message);
        res.json({ message: err.message, status: false });
    }
});

router.get('/viewFiles/:token', async (req, res) => {
    const {token} = req.params;
    if(!token)
    {
        return res.json({ message: "Please login!", status: false });
    }
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    const patient = await userPatientAuthModel.findById(decodedToken.userId);
    console.log(patient)
    if (!patient) {
        return res.json({ message: 'Patient not found!', status: false });
    }

    const userDir = path.join('./', `uploadedFiles/patient/${patient.userDetails.username}_${patient._id}`);
  console.log(userDir);
    try {
        // Check if directory exists
        if (!fs.existsSync(userDir)) {
            return res.json({ message: 'Directory not found', status: false });
        }

        // Read the directory contents
        const files = await readdir(userDir);

        // Send the list of files
        res.json({ status: true, message:`All files fetched!` ,files });
    } catch (error) {
        console.error('Error reading directory:', error);
        res.json({ message: 'Internal server error' });
    }


})



//Chatbot endpoint to query for user lifestyle suggestions.

router.post('/ai/:token', async (req, res) => {
    try {
        const { token } = req.params;
        if (!token) {
            return res.json({ message: "Please login!", status: false });
        }
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
        const patient = await userPatientAuthModel.findById(decodedToken.userId);
        if (!patient) {
            return res.json({ message: 'Patient not found!', status: false });
        }
        const { prompt } = req.body;
        let url = "http://localhost:5000/chat";
        axios.post(url, {
            input: prompt,
            mode: "t",
        }).then((response) => {
            console.log(response);
            const chat ={
                prompt: prompt,
                response: response.data.response,
                timeStamp: new Date()
            }
             mongoose.connection.db.collection(`patient_${decodedToken.userId}`).insertOne(chat);    

            res.json({ message: response.data.response, status: true });

        }).catch((err) => {
            console.log(err);
            res.json({ message: err.message, status: false });
        })
    }
    catch (err) {
        console.log(err.message);
        res.json({ message: err.message, status: false });
    }
});

export { router as userPatientAuthRouter };