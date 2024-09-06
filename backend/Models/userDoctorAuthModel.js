import mongoose from "mongoose";

const userDoctorSchema = new mongoose.Schema({
    doctorDetails: {
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
        security: {
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
    },
});


const userDoctorAuthModel = mongoose.model('DoctorAuth',userDoctorSchema);
export {userDoctorAuthModel};


