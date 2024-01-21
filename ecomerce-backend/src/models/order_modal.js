import mongoose from "mongoose";

const Schema = mongoose.Schema;
const orderItemSchema=new Schema({
    product:{type:Map,required:true}, 
    quantity:{type:Number ,default: 1}
});
 
const orderSchema= new Schema({
user:{type:Map,required:true},
items:{type:[orderItemSchema],default:[]}, 
status:{type:String,default:"order-placed"},
createdOn:{type:Date},
updatedOn:{type:Date},
});

orderSchema.pre('save',function(next){
  
    this.createdOn=new Date();
    this.updatedOn= new Date();
 
    next();
    
    
    
    
    });
    orderSchema.pre(['update','findOneAndUpdate','updateOne'],function (next){
        const update = this.getUpdate();
         delete update._id;
        
    this.updatedOn=new Date();
    next();
    });


export default mongoose.model('Order',orderSchema,)