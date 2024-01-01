import 'package:ecomerce_app/data/models/category/category_modal.dart';
import 'package:ecomerce_app/data/models/products/product_modal.dart';
import 'package:ecomerce_app/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:ecomerce_app/presentation/screens/auth/login.dart';
import 'package:ecomerce_app/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecomerce_app/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecomerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:ecomerce_app/presentation/screens/home/home_screen.dart';
import 'package:ecomerce_app/presentation/screens/orders/my_orders.dart';
import 'package:ecomerce_app/presentation/screens/orders/order_detail.dart';
import 'package:ecomerce_app/presentation/screens/orders/order_placed_screen.dart';
import 'package:ecomerce_app/presentation/screens/orders/providers/order_provider.dart';
import 'package:ecomerce_app/presentation/screens/product/category_product_screen.dart';
import 'package:ecomerce_app/presentation/screens/product/product_detail_screen.dart';
import 'package:ecomerce_app/presentation/screens/splash/splashscreen.dart';
import 'package:ecomerce_app/presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomerce_app/presentation/screens/auth/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignUpScreen()));

      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
            productModal: settings.arguments as ProductModal,
          ),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const EditProfileScreen());

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      CategoryProductCubit(settings.arguments as CategoryModal),
                  child: const CategoryProductScreen(),
                ));

      case OrderDetailsSrceen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderDetailProvider(),
                child: const OrderDetailsSrceen()));

      case MyOrders.routeName:
        return CupertinoPageRoute(builder: (context) => const MyOrders());
      default:
        return null; //404
    }
  }
}
