import 'package:ecomerce_app/data/models/category/category_modal.dart';
import 'package:ecomerce_app/data/repository/category_repo.dart';
import 'package:ecomerce_app/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }
  final _categoryRepository = CategoryRepo();
  void _initialize() async {
    emit(CategoryLoadingState(state.categories));
    try {
      List<CategoryModal> categories =
          await _categoryRepository.fetchAllCategories();
      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(CategoryErrorState(ex.toString(), state.categories));
    }
  }
}
