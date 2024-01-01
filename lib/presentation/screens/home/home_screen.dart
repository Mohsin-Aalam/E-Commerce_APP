import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecomerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecomerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:ecomerce_app/presentation/screens/home/category_screen.dart';
import 'package:ecomerce_app/presentation/screens/home/profile_screen.dart';
import 'package:ecomerce_app/presentation/screens/home/user_feed_screen.dart';
import 'package:ecomerce_app/presentation/screens/splash/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    //print(_selectedPageIndex);
  }

  List<Widget> widgetList = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  final PageController _pageController = PageController();

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('E-Commerce App'),
          actions: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Badge(
                    label: Text("${state.items.length}"),
                    isLabelVisible: (state is CartLoadingState) ? false : true,
                    child: const Icon(Icons.shopping_cart_outlined));
              },
            ))
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _selectPage,
          children: widgetList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          iconSize: 30,
          elevation: 0.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'Categories',
              activeIcon: Icon(Icons.category),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined),
                label: 'profile',
                activeIcon: Icon(Icons.person_3_rounded))
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedPageIndex,
        ),
      ),
    );
  }
}
