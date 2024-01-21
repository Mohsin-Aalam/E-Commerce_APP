import CartModal from "./../models/cart_modals.js";


const CartController={
   getCartForUser:async function (req,res){
    try{
        const user =  req.params.user;
        console.log('user' +user);
        const foundCart= await CartModal.findOne({
          user : user 
        }).populate("items.product");
        
        if ( !foundCart){
          return res.json({success : true , data:[]});
        }
        console.log( foundCart);
        return res.json({ success : true , data: foundCart.items});
    }catch(err){
        res.status(404).json({success:false,message : err});   

  
    }
      

   },

    addToCart:async function(req,res){
      

      try{ 
        const {product,user,quantity}=req.body;
        const foundCart=await CartModal.findOne({user:user});
        // if cart does not exist 
        if(!foundCart){
            const newCart= new CartModal({user:user});
            newCart.items.push({
              product:product,
              quantity:quantity,
            });
            await newCart.save();
            return res.json({success:true ,data:newCart,message : "product added to cart "});

        }
        //deleting the items if it is already exists
       const deletedItem= await CartModal.findOneAndUpdate(
          {user:user,"items.product":product},
          {$pull:{items:{product:product}}},
          {new:true}
        );
     // if cart alredy exists 
     //console.log("already exists");
   const updatedCart = await CartModal.findOneAndUpdate(
     {user:user},
     {$push: {items:{product:product ,quantity:quantity}}},
     { new:true }
   ).populate("items.product");
   //console.log(updatedCart);
     return res.json({success:true ,data: updatedCart.items,message : "product added to cart "});

  
 
      }catch(err){


        res.status(404).json({success:false,message : err});   
          
      }
    },
    removeFromCart:async function(req,res){
         try{
               const {user , product }=req.body;
               const updatedCart =await CartModal.findOneAndUpdate(
                {user:user},
                {$pull:{items:{product : product}}},
                {new:true}
               ).populate("items.product");
     return res.json({success:true ,data: updatedCart.items ,message : "Product remove from  cart "});

         }catch(err){
            return res.json({success:false ,message : err });

         }
    }
};

export default CartController;