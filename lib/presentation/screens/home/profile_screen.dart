import 'package:ecomerce_app/data/models/user/user_model.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecomerce_app/presentation/screens/orders/my_orders.dart';
import 'package:ecomerce_app/presentation/screens/user/edit_profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }
        return const Center(
          child: Text("An error occured!"),
        );
      },
    );
  }

  Widget userProfile(UserModal userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outlined),
              title: Text(
                "${userModel.fullName}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(
                "${userModel.email}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, EditProfileScreen.routeName);
                },
                leading: const Icon(Icons.edit),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.blueAccent),
                ))
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, MyOrders.routeName);
          },
          leading: const Icon(Icons.shopping_bag_sharp),
          title: const Text(
            "My Orders",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.redAccent,
          ),
          title: const Text(
            "Sign Out",
            style: TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
