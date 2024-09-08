import express from 'express';
import axios from 'axios';
import mongoose from 'mongoose';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken'
import qs from 'qs';
import {ObjectId} from 'mongodb'
import { userDoctorAuthModel } from '../Models/userDoctorAuthModel.js';
const router = express.Router();

router.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username  || !password ) {
            return res.json({ message: 'Please include all the required fields!', status: false });
        }

        if (username.length < 5 || username.length > 10) {
            return res.json({ message: 'Username should be between 5 and 10 characters!', status: false });
        }

        if (password.length < 8 || password.length > 16) {
            return res.json({ message: 'Password should be between 8 and 16 characters!', status: false });
        }


        // Check if email already exists
        const doctorExists = await userDoctorAuthModel.findOne({ 'doctorDetails.email': email });
        if (doctorExists) {
            return res.json({ message: 'User already exists!', status: false });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const newDoctor = new userDoctorAuthModel({
            doctorDetails: {
                username: username,
                email: email,
                password: hashedPassword,

            }
        });

        try {
            const savedDoctor = await newDoctor.save();

            const doctorCollectionName = `doctor_${savedDoctor._id}`;
            await mongoose.connection.db.createCollection(doctorCollectionName);

            res.json({ message: "Doctor signed up successfully!", status: true });
        } catch (error) {
            console.error(error.message);
            res.json({ message: error.message, status: false });
        }
    }
    catch (error) {
        console.error(error.message);
        res.json({ message: error.message, status: false });
    }
});

router.post('/login', async (req, res) => {
    try {
        const { password, regNo } = req.body;
        if (!regNo || !password) {
            return res.json({ message: 'Please provide email and password!', status: false });
        }
        const doctorExists = await userDoctorAuthModel.findOne({ 'doctorDetails.email': email });
        if (!doctorExists) {
            return res.json({ message: 'Doctor does not exist!', status: false });
        }
        const isMatch = await bcrypt.compare(password, doctorExists.doctorDetails.password);
        if (!isMatch) {
            return res.json({ message: 'Invalid email or password!', status: false });
        }

        const token = jwt.sign(
            { userId: doctorExists._id, email: doctorExists.doctorDetails.email },
            process.env.JWT_SECRET,
            { expiresIn: '24h' }
        );
        return res.json({ message: 'Login successful!', status: true, token: token });
    }
    catch (error) {
        console.error(error);
        res.json({ message: error.message, status: false });
    }
});


router.get('/view/:token', async (req, res) => {
    const { token } = req.params;
    const { id } = req.query;
    console.log(id)
    if (!token) {
        return res.json({ message: 'Please login first!', status: false });
    }

    if (!id) {
        return res.json({ message: 'Please provide id!', status: false });
    }

    try {
        // Convert the id to ObjectId
        const objectId = new ObjectId(id);

        // Access the native MongoDB collection
        const patient = await mongoose.connection.db.collection('patientauths').findOne({ _id: objectId });
        console.log()
        if (!patient) {
            return res.json({ message: 'No patient found!', status: false });
        }

        return res.json({ message: 'Patient found successfully!', patient: patient, status: true });
    } catch (err) {
        console.error('Error fetching patient:', err);
        return res.status(500).json({ message: 'An error occurred while fetching patient!', status: false });
    }
});


router.post('/deleteProfile/:token', async (req, res) => {
    try {
        const { token } = req.params;
        if (!token) {
            return res.json({ message: "Please login!", status: false });
        }
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
        await userDoctorAuthModel.findByIdAndDelete(decodedToken.userId);
        const doctorCollectionName = `doctor_${decodedToken.userId}`;
        await mongoose.connection.db.dropCollection(doctorCollectionName);
        res.json({ message: "Profile deleted successfully!", status: true });
    }
    catch (err) {
        console.error(err);
        return res.json({ message: err.message, status: false });
    }
});

// router.get('/logout', async (req, res) => {

// });

//Chatbot endpoint to query for user lifestyle suggestions.

router.post('/parkinsonAI/', async (req, res) => {
    try {
        const { prompt } = req.body;
        let url = "http://localhost:5001/predict";
        axios.post(url, {
            input: prompt,
            mode: "t"
        }).then((response) => {
            console.log(response)
            const chat = {
                prompt: prompt,
                response: response.data.response,
                timeStamp: new Date()
            }
            mongoose.connection.db.collection(`doctor_${decodedToken.userId}`).insertOne(chat);
            console.log("chat inserted!")
            return res.json({ prompt: prompt, response: response.data.response, timeStamp: new Date() })
        }).catch((err) => {
            console.error(err);
            return res.json({ message: err.message, status: false })
        })
    }
    catch (err) {
        console.error(err);
        return res.json({ message: err.message, status: false })
    }
});

router.post('/heartDieseaseAI/', async (req, res) => {
    try {
        const { age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal,  } = req.bo
        const { prompt } = req.body;
        let url = "http://localhost:5001/predict";
        axios.post(url, {
            age: age,
            sex: sex,
            cp: cp,
            trestbps: trestbps,
            chol: chol,
            fbs: fbs,
            restecg: restecg,
            thalach: thalach,
            exang: exang,
            oldpeak: oldpeak,
            slope: slope,
            ca: ca,
            thal: thal
        },
    {
        headers: {
            'Content-Type': 'application/json'  // Setting the Content-Type to application/json
        }
    }).then((response) => {
            const chat = {
                prompt: prompt,
                response: response.data.prediction,
                timeStamp: new Date()
            }
            mongoose.connection.db.collection(`doctor_${decodedToken.userId}`).insertOne(chat);
            console.log("chat inserted!")
            return res.json({ prompt: prompt, response: response.data.prediction, timeStamp: new Date() })
        }).catch((err) => {
            console.error(err);
            return res.json({ message: err.message, status: false })
        })
    }
    catch (err) {
        console.error(err);
        return res.json({ message: err.message, status: false })
    }
});

router.post('/generalAI/', async (req, res) => {
    try {
        const { symptoms } = req.body;
        let url = "http://localhost:5001/predict";
        axios.post(url, {
            symptoms: symptoms,
        }).then((response) => {
            console.log(response)
            const chat = {
                prompt: prompt,
                response: response.data.response,
                timeStamp: new Date()
            }
            mongoose.connection.db.collection(`doctor_${decodedToken.userId}`).insertOne(chat);
            console.log("chat inserted!")
            return res.json({ prompt: prompt, response: response.data.response, timeStamp: new Date() })
        }).catch((err) => {
            console.error(err);
            return res.json({ message: err.message, status: false })
        })
    }
    catch (err) {
        console.error(err);
        return res.json({ message: err.message, status: false })
    }
});

export { router as userDoctorAuthRouter };