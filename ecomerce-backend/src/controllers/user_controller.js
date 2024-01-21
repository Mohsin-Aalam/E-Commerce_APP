
import UserModal from './../models/user_modal.js';
import bcrypt from "bcrypt"; 
const UserController={
    createAccount:async function (req,res){
            try{
                const userData=req.body;
                 //console.log(userData);
                const newUser=new UserModal(userData);
                await newUser.save();
                return res.json({success:true,data:newUser,message:"User created! "});


            }catch(err){
                 res.json({
                    success:false, message :err
                 })
            }
    },

    signIn:async function( req,res){
        try{
            const {email ,password}=req.body;

            const foundUser= await UserModal.findOne({email:email});
            console.log(foundUser);
            if(!foundUser){
                return res.json({success:false, message : "User not found!"});

            }
            const passwordMatch=bcrypt.compareSync(password,foundUser.password);
              if(!passwordMatch){
               return res.json({
                    success:false, message :"Incorrect password!"
                 });
              }
              return res.json({success:true ,data:foundUser});
        }catch(err){
            res.json({
                success:false, message :err
             });
        }
    },

    updateUser:async function(req,res){
        try{
               const userId=req.params.id;
               console.log(userId);
               const updateData=req.body;
               console.log(updateData);
            
               const updatedUser=await UserModal.findOneAndUpdate(
                {
                _id:userId},
                updateData,
                {new:true}
                );
                console.log(updatedUser);
                if(!updatedUser){
                    throw "user not found!"
                }
                return res.json({success:true,data:updatedUser,message:'user updated!'})
        }catch(ex){
            console.log(ex);
            res.json({
                success:false, message :ex
             });
        }
    }
};
export default UserController