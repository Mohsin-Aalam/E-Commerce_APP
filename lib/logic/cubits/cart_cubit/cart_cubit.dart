import 'dart:async';

import 'package:ecomerce_app/data/models/cart/cart_modal.dart';
import 'package:ecomerce_app/data/models/products/product_modal.dart';
import 'package:ecomerce_app/data/repository/cart_repo.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    _handleUserState(_userCubit.state);
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  void sortAndLoad(List<CartModal> items) {
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items));
  }

  final _cartRepo = CartRepo();
  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cartRepo.fetchCartForUser(userId);
      sortAndLoad(items);
    } catch (ex) {
      emit(CartErrorState(state.items, ex.toString()));
    }
  }

  bool cartContains(ProductModal product) {
    if (state.items.isNotEmpty) {
      final isExist = state.items.any((p) => p.product!.sId == product.sId);

      if (isExist) return true;

      // final foundItem=state.items.where((item) => item.product!.sId==product.sId!).toList();
    }
    return false;
  }

  void clearCart() {
    emit(CartLoadedState([]));
  }

  void addToCart(ProductModal product, int quantity) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;
        CartModal newCartItem = CartModal(
          product: product,
          quantity: quantity,
        );
        final items = await _cartRepo.addProductToCart(
            newCartItem, userState.userModel.sId!);
        sortAndLoad(items);
      } else {
        throw "an error occured while adding the item!";
      }
    } catch (ex) {
      emit(CartErrorState(state.items, ex.toString()));
    }
  }

  void removeFromCart(ProductModal product) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartRepo.removeFromCart(
            product.sId!, userState.userModel.sId!);
        sortAndLoad(items);
      } else {
        throw "an error occured while removing the item!";
      }
    } catch (ex) {
      emit(CartErrorState(state.items, ex.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
