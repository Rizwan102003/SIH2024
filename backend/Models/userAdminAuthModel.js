import mongoose from 'mongoose';

const userAdminSchema = new mongoose.Schema({
    adminDetails: {
        username: {
            type: String,
            required: true,
            maxlength: 10,
            minlength: 5,
        },
        InstitutionEmail: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
    
        },
        InstitutionName: {
            type: String,
            required: true,
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
    },
});

const userAdminAuthModel = mongoose.model('adminAuth',userAdminSchema);
export {userAdminAuthModel};
