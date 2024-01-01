import 'dart:async';

import 'package:ecomerce_app/data/models/cart/cart_modal.dart';
import 'package:ecomerce_app/data/models/orders/orders_modal.dart';
import 'package:ecomerce_app/data/repository/order_repo.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';

import 'package:ecomerce_app/logic/cubits/order_cubit/order_state.dart';

import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    _handleUserState(_userCubit.state);
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  final _productRepo = OrderRepo();

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _productRepo.fetchOrdersForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(OrderErrorState(state.orders, ex.toString()));
    }
  }

  Future<bool> createOrder({
    required List<CartModal> items,
    required String paymentMethod,
  }) async {
    if (_userCubit.state is! UserLoggedInState) {
      return false;
    }
    emit(OrderLoadingState(state.orders));
    try {
      OrderModel newOrder = OrderModel(
          items: items,
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == 'pay-on-delivery')
              ? "order-placed"
              : "payment-pending");
      final order = await _productRepo.createOrder(newOrder);
      List<OrderModel> orders = [order, ...state.orders];

      emit(OrderLoadedState(orders));
      _cartCubit.clearCart();
      return true;
    } catch (ex) {
      emit(OrderErrorState(state.orders, ex.toString()));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

//Order(Backed) ---order_id--->Frontend (order_id:Payment)