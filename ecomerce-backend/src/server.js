import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';
import  cors from 'cors';
import mongoose from 'mongoose';
import userRoutes from './routes/user_routes.js'; 
import cartRoutes from "./routes/cart_routes.js";
import categoryRoutes from './routes/categories_routes.js';
import productRoutes from './routes/product_routes.js';
import OrderRoutes from './routes/order_routes.js';

const app = express();
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());
app.use(express.json())
mongoose.connect("mongodb+srv://greenstore987:greenstore@cluster0.hdkvf8p.mongodb.net/ecomerce").then(()=>{
    console.log("db connected");


});


app.use("/api/user/",userRoutes);
app.use("/api/category",categoryRoutes);
app.use("/api/product",productRoutes);
app.use("/api/cart",cartRoutes);
app.use("/api/order",OrderRoutes);




const PORT=5000;
app.listen(PORT,()=>console.log(`Server started at PORT:${PORT}`));
 