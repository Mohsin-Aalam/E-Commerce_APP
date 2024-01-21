
import CategoryModal from "./../models/category.js";


const CategoryController = {
    createCategory: async function (req, res) {
        try { 
           const categoryData=req.body;
           const newCategory=new CategoryModal(categoryData);
            await newCategory.save();

            return res.json({success:true,data:newCategory,message:"new Category created!"});
        } catch (err) {
            return res.json({ success: false, message: err })

        }
    },
    fetchAllCategories: async function (req, res) {
        try { 
         const categories=await CategoryModal.find();
       

            return res.json({success:true,data:categories});
        } catch (err) {
            return res.json({ success: false, message: err })

        }
    },
    fetchCategoriesById: async function (req, res) {
        try { 
            const id = req.params.id;
         const foundCategoryById=await CategoryModal.findById(id);
             if(!foundCategoryById){
                return res.json({ success: false, message: "Category not Found!" })   
             }
              
            return res.json({success:true,data:foundCategoryById});
        } catch (err) {
            return res.json({ success: false, message: err })

        }
    }
};
export default CategoryController;