import mongoose from 'mongoose';

const userAdminSchema = new mongoose.Schema({
    adminDetails: {
        username: {
            type: String,
            required: true,
            maxlength: 16,
            minlength: 10,
        },
        InstitutionEmail: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
            maxlength: 16,
            minlength: 8,
        },
        InstitutionName: {
            type: String,
            required: true,
        },
        security:{
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