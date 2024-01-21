import mongoose from "mongoose";

const Schema = mongoose.Schema;
 
const productSchema= new Schema({
category:{type:Schema.Types.ObjectId,ref:'Category',required:true},    
title:{type : String ,required:[true, ' title is required']},
description:{type: String,default:""},
price:{type:Number,required:true},
images:{type:Array,default:[]},
createdOn:{type:Date},
updatedOn:{type:Date},
});

productSchema.pre('save',function(next){
  
    this.createdOn=new Date();
    this.updatedOn= new Date();
 
    next();
    
    
    
    
    });
    productSchema.pre(['update','findOneAndUpdate','updatedOne'],function (next){
        const update = this.getUpdate();
         delete update._id;
        
    this.updatedOn=new Date();
    next();
    });


export default mongoose.model('Product',productSchema,)