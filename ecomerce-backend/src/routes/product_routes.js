import ProductController from "./../controllers/product_controller.js"
import express from 'express';
const productRoutes=express.Router();

productRoutes.post('/',ProductController.createProduct);
productRoutes.get('/category/:id',ProductController.fetchProductsByCategory); 

productRoutes.get('/',ProductController.fetchAllProducts); 
export default productRoutes;