import mongoose from "mongoose";

const userDoctorSchema = new mongoose.Schema({
    doctorDetails: {
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
        security: {
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
        }
    },
});


const userDoctorAuthModel = mongoose.model('DoctorAuth',userDoctorSchema);
export {userDoctorAuthModel};


