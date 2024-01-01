import 'package:ecomerce_app/data/models/user/user_model.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = "edit_profile";
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(child: BlocBuilder<UserCubit, UserState>(
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
            return editProfile(state.userModel, context);
          }
          return const Center(
            child: Text("An error occured!"),
          );
        },
      )),
    );
  }
}

Widget editProfile(UserModal userModel, BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16.0),
    children: [
      const Text(
        "Personal Details",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),
      TextFormField(
        onChanged: (value) {
          userModel.fullName = value;
        },
        initialValue: userModel.fullName,
        decoration: const InputDecoration(
            labelText: 'Full Name', enabledBorder: OutlineInputBorder()),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      TextFormField(
        onChanged: (value) {
          userModel.phoneNumber = value;
        },
        initialValue: userModel.phoneNumber,
        decoration: const InputDecoration(
            labelText: 'Phone Number', enabledBorder: OutlineInputBorder()),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      const Text(
        "Address",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),
      TextFormField(
        onChanged: (value) {
          userModel.address = value;
        },
        initialValue: userModel.address,
        decoration: const InputDecoration(
            labelText: 'Address', enabledBorder: OutlineInputBorder()),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      TextFormField(
        onChanged: (value) {
          userModel.city = value;
        },
        initialValue: userModel.city,
        decoration: const InputDecoration(
            labelText: 'City', enabledBorder: OutlineInputBorder()),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      TextFormField(
        onChanged: (value) {
          userModel.state = value;
        },
        initialValue: userModel.state,
        decoration: const InputDecoration(
            labelText: 'State', enabledBorder: OutlineInputBorder()),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      CupertinoButton(
          color: Colors.blue,
          onPressed: () {
            BlocProvider.of<UserCubit>(context).updateUser(userModel);

            Navigator.pop(context);
          },
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 20),
          ))
    ],
  );
}
