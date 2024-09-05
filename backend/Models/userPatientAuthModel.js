import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    userDetails: {
        username: {
            type: String,
            required: true,
            maxlength: 10,
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
            hasChronicIllness: {
                type: Boolean,
                required: false,
            },
            ChronicIllness: {
                type: [String],
                default: [],
            },
        },
        allergies: {
            hasAllergies: {
                type: Boolean,
                required: false,
            },
            allergies: {
                type: [String],
                default: [],
            },
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

