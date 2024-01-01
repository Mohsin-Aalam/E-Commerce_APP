import 'package:ecomerce_app/data/models/category/category_modal.dart';
import 'package:ecomerce_app/data/repository/product_repo.dart';
import 'package:ecomerce_app/logic/cubits/category_product_cubit/category_product_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModal category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final _productRepo = ProductRepo();
  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products =
          await _productRepo.fetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(state.products, ex.toString()));
    }
  }
}
