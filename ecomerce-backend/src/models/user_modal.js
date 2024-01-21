import mongoose from "mongoose";
const Schema = mongoose.Schema;
import bcrypt from "bcrypt";
import { v1 as uuidv1 } from 'uuid';
const userSchema = new Schema({
    id: {type: String, unique: true},
    fullName: { type: String, default: "" },
    email: { type: String, unique: true, required: true},
    password: { type: String, required: true },
    phoneNumber: { type: String, default: '' },
    address: { type: String, default: '' },
    city: { type: String, default: '' },
    state: {type: String, default: ''},
    progressNumber: { type: Number, default: '0' },
   updatedOn:{type:Date},
   createdOn:{type:Date}

});
userSchema.pre('save',function(next){
this.id=uuidv1();
this.createdOn=new Date();
this.updatedOn= new Date();
const salt =bcrypt.genSaltSync(10);
const hash =bcrypt.hashSync(this.password,salt);
this.password=hash;
next();




});
userSchema.pre(['update','findOneAndUpdate','updatedOne'],function (next){
    
    const update = this.getUpdate();
     delete update._id;
     delete update.id;
this.updatedOn=new Date();
next();
});
 export default mongoose.model('User',userSchema,'users');
