import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import express from 'express'
import cookieParser from 'cookie-parser';
const app = express();
 app.use(express.json());
 app.use(cookieParser());
dotenv.config({path:'./secrets.env'})
// Middleware to extract and attach user ID to the request
const extractUserId = (req, res, next) => {
   // Extract token from Authorization header
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
    console.log("Token extracted from Authorization header: " + token);
  if (token == null) return res.json({message: 'No token provided!', status:false});

  // Verify the token
  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.json({message:err.message, status:false}); 
    req.user = user;
    next();
  });
};

export  { extractUserId };