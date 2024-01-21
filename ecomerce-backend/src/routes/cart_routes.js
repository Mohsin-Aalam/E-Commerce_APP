import express from "express";
import CartController from "./../controllers/cart_controllers.js";

const cartRouter=express.Router();
cartRouter.get("/:user",CartController.getCartForUser); 
cartRouter.post("/",CartController.addToCart);
cartRouter.delete("/",CartController.removeFromCart);


export default cartRouter;