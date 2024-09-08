import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    userDetails: {
        username: {
            type: String,
            required: false,
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
            required: false,
        },
        dob:{
            type: Date,
            required: false,
        },
        age:{
            type: Number,
            required: false,
        },
        gender: {
            type: String,
            required: false,
            enum: ['male', 'female', 'm', 'f', 'Male', 'Female', 'M', 'F'],
        }
    },
    healthDetails: {
        height: {
            type: Number,
            required: false,
        },
        weight: {
            type: Number,
            required: false,
        },
        bloodType: {
            type: String,
            required: false,
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

