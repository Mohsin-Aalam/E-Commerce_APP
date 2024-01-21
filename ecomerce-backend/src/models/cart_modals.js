import mongoose from "mongoose";

const Schema = mongoose.Schema;
const cartItemSchema=new Schema({
    product:{type:Schema.Types.ObjectId, ref: 'Product'},
    quantity:{type:Number ,default: 1}
});
 
const cartSchema= new Schema({
user:{type:Schema.Types.ObjectId,ref:"User",required:true},
items:{type:[cartItemSchema],default:[]}, 
createdOn:{type:Date},
updatedOn:{type:Date},
});

cartSchema.pre('save',function(next){
  
    this.createdOn=new Date();
    this.updatedOn= new Date();
 
    next();
    
    
    
    
    });
    cartSchema.pre(['update','findOneAndUpdate','updateOne'],function (next){
        const update = this.getUpdate();
         delete update._id;
        
    this.updatedOn=new Date();
    next();
    });


export default mongoose.model('Cart',cartSchema,)