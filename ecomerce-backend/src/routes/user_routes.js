import express from 'express';
import UserController from '../controllers/user_controller.js';
const router= express.Router();

router.post('/createAccount',UserController.createAccount); 
router.post('/signIn',UserController.signIn); 
router.put('/:id',UserController.updateUser); 



export default router;