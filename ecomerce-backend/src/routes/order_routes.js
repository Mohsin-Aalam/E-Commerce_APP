import express from "express";
import OrderController from "./../controllers/order_Controller.js";

const orderRouter=express.Router();

orderRouter.get("/:userId",OrderController.fetchOrdersForUser);
orderRouter.put("/updateStatus",OrderController.updateOrderStatus);

orderRouter.post("/",OrderController.createOrder);




export default orderRouter;