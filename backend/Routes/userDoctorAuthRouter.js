import express from 'express';
import axios from 'axios';
const router = express.Router();
import {db, admin, serviceAccount} from '../firebaseConfig.js';

router.post('/signup', async (req, res) => {
    //firebase code
    const { username, email, password } = req.body;
    try {
        const userRecord = await admin.auth().createUser({
            username: username,
            email: email,
            emailVerified: false,
            password: password,
        });
        console.log('Successfully created new user:', userRecord.uid);
        res.json({message:`Successfully created new user: ${userRecord.uid}`, status:true})
    } catch (error) {
        console.error('Error creating new user:', error);
        res.json({message: error.message, status:false})
    }
})

router.post('/login', async (req, res) => {
    //firebase code
})

router.get('/profile/:userId', async (req, res) => {
    //firebase code
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

export { router as userDoctorAuthRouter };