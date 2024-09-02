import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    userDetails: {
        username: {
            type: String,
            required: true,
            maxlength: 16,
            minlength: 10,
        },
        email: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
            maxlength: 16,
            minlength: 8,
        },
        fullName: {
            type: String,
            required: true,
        },
        lastLogin: {
            type: Date,
            required: true,
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
            required:true
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
        vision:{
            type:String,
            required:true
        },
        bloodType: {
            type: String,
            required: true,
        },
        chronicIllness: {
            hasChronicIllness: {
                type: Boolean,
                required: true,
            },
            ChronicIllness: {
                type: [String],
                default: [],
            },
        },
        allergies: {
            hasAllergies: {
                type: Boolean,
                required: true,
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
                default: Date.now, // Default value set to the current date and time
            },
        },
    }
});

const userPatientAuthModel = mongoose.model('Auth',userSchema);
export {userPatientAuthModel};

