import 'package:ecomerce_app/data/repository/product_repo.dart';
import 'package:ecomerce_app/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }
  final _productRepo = ProductRepo();
  void _initialize() async {
    emit(ProductLoadingsState(state.product));
    try {
      final products = await _productRepo.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(state.product, ex.toString()));
    }
  }
}
