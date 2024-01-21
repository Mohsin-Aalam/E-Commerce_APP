import OrderModal from "./../models/order_modal.js";
import CartModel from  "./../models/cart_modals.js";

const OrderController={
   createOrder:async function (req,res){
    try{
         const {user, items ,status }=req.body;
         const newOrder=new OrderModal({
            user:user,
            items:items,
            status:status
         });  
         //console.log(newOrder);
         await newOrder.save();

         await CartModel.findOneAndUpdate({
            user:user._id

         },
         {items:[]}
         
         )
         return res.json({
            success:true,
            data:newOrder,
            message:"order created!"
         })

    }catch(err){
        res.status(404).json({success:false,message : err});   

  
    }
      

   } ,
   fetchOrdersForUser:async function (req,res){
    try{
        const userId = req.params.userId;
        const foundOrders= await OrderModal.find({
             "user._id":userId
        }).sort({createdOn:-1});
        return res.json ({success : true ,data:foundOrders});

   
    }catch(err){
        res.status(404).json({success:false,message : err});   

  
    }
      

   } ,
   updateOrderStatus: async function (req, res){
    try{
             const {orderId,status} =req.body;
             const updatedOrder=await OrderModal.findOneAndUpdate(
             {_id:orderId},
             {status:status},
             {new:true}
             );
        return res.json ({success : true ,data:updatedOrder});

   
    }catch(err){
        res.status(404).json({success:false,message : err});   

  
    }
   }
};

export default OrderController;