import express from 'express';
import CategoryController from '../controllers/category_controller.js';
const CategoryRoutes= express.Router();

CategoryRoutes.get('/',CategoryController.fetchAllCategories); 
CategoryRoutes.get('/:id',CategoryController.fetchCategoriesById); 

CategoryRoutes.post('/',CategoryController.createCategory);


export default CategoryRoutes;