import 'dart:developer';

import 'package:ecomerce_app/core/routes.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/cubits/category_cubit/category_cubit.dart';
import 'package:ecomerce_app/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecomerce_app/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';

import 'package:ecomerce_app/presentation/screens/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(BlocProvider.of<UserCubit>(context)),
        ),
        BlocProvider(
          create: (context) => OrderCubit(BlocProvider.of<UserCubit>(context),
              BlocProvider.of<CartCubit>(context)),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 112, 241, 231)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("created:  $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("change in $bloc:$change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("change in $bloc : $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
