import mongoose from "mongoose";

const Schema = mongoose.Schema;
 
const categorySchema= new Schema({
title:{type : String ,required:[true, ' title is required']},
description:{type: String,default:""},
createdOn:{type:Date},
updatedOn:{type:Date},
});

categorySchema.pre('save',function(next){
  
    this.createdOn=new Date();
    this.updatedOn= new Date();
 
    next();
    
    
    
    
    });
    categorySchema.pre(['update','findOneAndUpdate','updateOne'],function (next){
        const update = this.getUpdate();
         delete update._id;
        
    this.updatedOn=new Date();
    next();
    });


export default mongoose.model('Category',categorySchema,)