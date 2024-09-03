import express from 'express';
import axios from 'axios';
import bcrypt from 'bcrypt';
import {userPatientAuthModel} from '../Models/userPatientAuthModel.js'
const router = express.Router();

router.post('/signup', async (req, res) => {
    try{
        const { username, email, password, fullName, height, weight, bloodType,  lastCheckUpDoctor, lastCheckUpDate } = req.body;

    if(!username || !email || !password || !fullName || !height || !weight || !bloodType || !lastCheckUpDoctor || !lastCheckUpDate || !vision){
        res.json({message:'Please include all the mandatory fields!', status:false});
    }
    if(username.length<=10 || username.length>=16)
    {
        res.json({message:'Please enter username between 10 and 16 characters!', status:false});
    }
    if(password.length<8 || password.length>=16){
        res.json({message:'Please ensure password length is between 8 and 16 characters.', status:false});
    }
    if(typeof(fullName)!=='string')
    {
        res.json({message:'Please ensure full name is of type string', status:false})
    }
    const hashPassword = await bcrypt.hash(password, 10);
    const newPatient = new userPatientAuthModel({
        userDetails:{
            username:username,
            email:email,
            password:hashPassword,
            fullName:fullName
        },
        healthDetails:{
            height:height,
            weight:weight,
            bloodType:bloodType,
            bloodType:bloodType,
            lastCheckUp:{
                lastCheckUpDoctor:lastCheckUpDoctor,
                lastCheckUpDate:lastCheckUpDate
            }
        }
    });
    await newPatient.save();
    const patientCollectionName = `patient_${newPatient._id}`;
    await mongoose.connection.db.createCollection(patientCollectionName);
    res.json({message:'Your Registration was successful!'});
    }
    catch(err){
        console.log(err.message);
        res.json({message:err.message, status:true});
    };
});

router.post('/login', async (req, res) => {
    
})

router.get('/profile/:userId', async (req, res) => {
    
})

router.post('/updateProfile', async (req, res) => {
    //firebase code
})

router.post('/deleteProfile', async (req, res) => {
    //firebase code
});

router.post('/uploadfiles', async (req, res) => {
    //firebase code
});

router.get('/logout', async (req, res) => {
    //write code
});

//Chatbot endpoint to query for user lifestyle suggestions.

router.post('/ai/suggestions', async (req, res) => {

})

router.post('/ai/symptoms', async (req, res) => {

});

export { router as userPatientAuthRouter };