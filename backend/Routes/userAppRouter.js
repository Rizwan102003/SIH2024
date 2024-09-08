import express from 'express';
import axios from 'axios';
const router = express.Router();

router.get('/',(req, res)=>{
    res.json({message:'Welcome user!', status: true});
});



export {router as userAppRouter};

