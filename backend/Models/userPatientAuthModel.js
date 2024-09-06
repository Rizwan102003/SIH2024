import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    userDetails: {
        username: {
            type: String,
            required: true,
            maxlength: 15,
            minlength: 5,
        },
        email: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
        },
        fullName: {
            type: String,
            required: true,
        },
        dob:{
            type: Date,
            required: true,
        },
        age:{
            type: Number,
            required: true,
        },
        gender: {
            type: String,
            required: true,
            enum: ['male', 'female', 'm', 'f', 'Male', 'Female', 'M', 'F'],
        }
    },
    healthDetails: {
        height: {
            type: Number,
            required: true,
        },
        weight: {
            type: Number,
            required: true,
        },
        bloodType: {
            type: String,
            required: true,
        },
        chronicIllness: {
            type: [String],
            default: [],
        },
        allergies: {
            type: [String],
            default: [],
        },
        lastCheckUp: {
            lastCheckUpDoctor: {
                type: String,
                required: false,
            },
            lastCheckUpDate: {
                type: Date,
                default: Date.now,
            },
        },
        lastMedication:{
            type: String,
            required: false,
            default:""
        }
    },
    security:{
        lastLogin: {
            type: Date,
            required: false,
        },
        failedLogin: {
            type: Number,
            default: 0,
        },
        createdAt:{
            type:Date,
            default:Date.now
        },
        updatedAt:{
            type:Date,
            required:false
        }
    }
});

const userPatientAuthModel = mongoose.model('PatientAuth',userSchema);
export {userPatientAuthModel};

