import express from 'express';
import mongoose from 'mongoose';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import fs from 'fs';
import { userAdminAuthModel } from '../models/userAdminAuthModel.js';
import multer from 'multer';
import path from 'path';
import { promisify } from 'util';

const router = express.Router();
const readdir = promisify(fs.readdir);

// Set up storage configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const { username } = req.query;
    const { id } = req.params;
    cb(null, `uploadedFiles/patient/${username}_${id}/`); // Directory to save the files
  },
  filename: (req, file, cb) => {
    // Use the ID from the request parameters for the filename
    const { id } = req.params;
    const date = new Date();
    const year = date.getFullYear();                // Get the year (e.g., 2024)
    const month = date.getMonth() + 1;              // Get the month (0-based, so add 1 for human-readable format)
    const day = date.getDate();                     // Get the day of the month
    const hours = date.getHours();                  // Get the hours
    const minutes = date.getMinutes();              // Get the minutes
    const seconds = date.getSeconds();              // Get the seconds

    // Format the date as a string (e.g., YYYY-MM-DD-HH-MM-SS)
    const formattedDate = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}-${String(hours).padStart(2, '0')}-${String(minutes).padStart(2, '0')}-${String(seconds).padStart(2, '0')}`;
    const ext = path.extname(file.originalname);
    cb(null, `patient_medicalRecord_${formattedDate}_${id}${ext}`); // Use ID as filename with original extension
  }
});

// File filter to ensure only certain types of files are uploaded
const fileFilter = (req, file, cb) => {
  // Allowed file extensions
  const allowedExtensions = /jpg|jpeg|png|pdf/;
  const extname = allowedExtensions.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedExtensions.test(file.mimetype);

  if (extname && mimetype) {
    return cb(null, true);
  } else {
    cb(new Error('Only images and PDFs are allowed!'));
  }
};

// Initialize multer with the storage and file filter configurations
const upload = multer({
  storage: storage,
  fileFilter: fileFilter
});


router.post('/signup', async (req, res) => {
  try {
    const { username, InstitutionEmail, InstitutionName, password } = req.body;

    if (!username || !InstitutionEmail || !password || !InstitutionName) {
      return res.json({ message: 'Please provide all required fields!', status: false });
    }
    if (username.length < 5 || username.length > 10) {
      return res.json({ message: 'Please enter username between 5 and 10 characters!', status: false });
    }
    if (password.length < 8 || password.length >= 16) {
      return res.json({ message: 'Please ensure password length is between 8 and 16 characters.', status: false });
    }

    const adminExists = await userAdminAuthModel.findOne({ 'adminDetails.InstitutionEmail': InstitutionEmail });
    if (adminExists) {
      return res.json({ status: false, message: "Admin already exists!" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newAdmin = new userAdminAuthModel({
      adminDetails: {
        username: username,
        InstitutionEmail: InstitutionEmail,
        InstitutionName: InstitutionName,
        password: hashedPassword,
      },
    });
    const savedAdmin = await newAdmin.save();

    const adminCollectionName = `doctor_${savedAdmin._id}`;
    await mongoose.connection.db.createCollection(adminCollectionName);

    res.json({ message: 'Admin successfully saved!', status: true });
  }
  catch (error) {
    console.error(error.message);
    res.json({ message: error.message, status: false });
  }
});


router.post('/login', async (req, res) => {
  try {
    const { InstitutionEmail, InstitutionName, password } = req.body;
    if (!InstitutionEmail || !InstitutionName || !password) {
      return res.json({ message: 'Please provide email and password!', status: false });
    }
    const adminExists = await userAdminAuthModel.findOne({
      'adminDetails.InstitutionEmail': InstitutionEmail,
      'adminDetails.InstitutionName': InstitutionName
    });

    if (!adminExists) {
      return res.json({ message: 'Invalid email or password!', status: false });
    }
    const isMatch = await bcrypt.compare(password, adminExists.adminDetails.password);
    if (!isMatch) {
      return res.json({ message: 'Invalid email or password!', status: false });
    }
    const token = jwt.sign({ id: adminExists._id }, process.env.JWT_SECRET, { expiresIn: '1d' });
    res.json({ message: 'Logged in successfully!', status: true, token: token });
  }
  catch (error) {
    console.error(error.message);
    res.json({ message: error.message, status: false });
  }
});

router.post('/patients/:token', async (req, res) => {
  try {
    const { token } = req.params;
    const { sortFunc } = req.body;

    if (!token) {
      return res.json({ message: 'Please login!', status: false });
    }

    // Verify the token
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) return res.json({ message: err.message, status: false });
    });

    // Fetch all patients from the database
    const collection = mongoose.connection.db.collection('patientauths');

    if (sortFunc == 'age') {
      const patients = await collection.find({})
        .sort({ 'userDetails.age': 1 })  // Sort by age in ascending order
        .toArray();
      return res.json({ message: 'Patients sorted by age.', status: true, patients: patients });
    } else if (sortFunc == 'username') {
      const patients = await collection.find({})
        .sort({ 'userDetails.username': 1 })  // Sort by username in ascending order
        .toArray();
      return res.json({ message: 'Patients sorted by username.', status: true, patients: patients });
    } else if (sortFunc == 'dob') {
      const patients = await collection.find({})
        .sort({ 'userDetails.dob': 1 })  // Sort by date of birth in ascending order
        .toArray();
      return res.json({ message: 'Patients sorted by Date of Birth.', status: true, patients: patients });
    }
    else {
      const patients = await collection.find({})
        .toArray();  // Fetch all patients from the database
      return res.json({ message: 'All current patients sent!', status: true, patients: patients });
    }

    // Send the list of patients as a response

  } catch (error) {

    console.error(error.message);
    return res.json({ message: error.message, status: false });
  }
});


router.post('/addFiles/:token', upload.single('file'), async (req, res) => {
  const { id } = req.query;
  const { token } = req.params;
if (!token) {
      return res.json({ message: 'Please login!', status: false });
    }

    // Verify the token
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) return res.json({ message: err.message, status: false });
    });
  // const {  }
  const patient = await mongoose.connection.db.collection('patientauths').findOne({ _id: new mongoose.Types.ObjectId(id) });

  // If no patient is found
  if (!patient) {
    return res.json({ message: 'Patient not found!', status: false });
  }
  console.log(req.file)

  return res.json({ message: 'File uploaded!', status: true });

});


router.get('/viewFiles/:token', async (req, res) => {
  const { token } = req.params;
  const {id, username } = req.query;
if (!token) {
      return res.json({ message: 'Please login!', status: false });
    }

    // Verify the token
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) return res.json({ message: err.message, status: false });
    });
  const userDir = path.join('./', `uploadedFiles/patient/${username}_${id}`);
  console.log(userDir);
    try {
        // Check if directory exists
        if (!fs.existsSync(userDir)) {
            return res.json({ message: 'Directory not found', status: false });
        }

        // Read the directory contents
        const files = await readdir(userDir);

        // Send the list of files
        res.json({ status: true, message:`Show files for ${username}_${id}` ,files });
    } catch (error) {
        console.error('Error reading directory:', error);
        res.json({ message: 'Internal server error' });
    }
});

router.get('/inventory/:token',async (req, res) => {
  const { token } = req.params;
  if (!token) {
        return res.json({ message: 'Please login!', status: false });
      }
  
      // Verify the token
      jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) return res.json({ message: err.message, status: false });
      });

      //add remaining code


      await mongoose.connection.db.createCollection("MedicineInventory");
});


export { router as userAdminAuthRouter };
