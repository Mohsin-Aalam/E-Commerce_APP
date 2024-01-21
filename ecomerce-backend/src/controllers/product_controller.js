import category from "../models/category.js";
import ProductModal from "./../models/product_modal.js";

const ProductController={ 
    createProduct:async function(req,res){
          try{
            const productData=req.body;
            console.log(productData);
            const newProduct=new ProductModal(productData);
            await newProduct.save();
            return res.json({success:true , data:newProduct,message:"product Created! "});

          }catch(err){
             return res.json({success: false, message: err});
          }
    },

    fetchAllProducts: async function(req,res){
        try{
        
          const Products=await ProductModal.find(); 

          return res.json({success:true , data:Products,});

        }catch(err){
           return res.json({success: false, message: err});
        }
  },

  fetchProductsByCategory: async function(req,res){
    try{
          const categoryId=req.params.id;  
      const Products=await ProductModal.find({category:categoryId}); 

      return res.json({success:true , data:Products,});

    }catch(err){
       return res.json({success: false, message: err});
    }
}
};
export default ProductController;