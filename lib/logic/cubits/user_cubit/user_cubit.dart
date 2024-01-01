import 'package:ecomerce_app/data/models/user/user_model.dart';
import 'package:ecomerce_app/data/repository/user_repo.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecomerce_app/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }
  final UserRepo _userRepo = UserRepo();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];
    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(
      {required UserModal userModal,
      required String email,
      required String password}) async {
    await Preferences.saveUserDetails(email, password);

    emit(UserLoggedInState(userModal));
  }

  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModal userModal =
          await _userRepo.signIn(email: email, password: password);
      _emitLoggedInState(
          userModal: userModal, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLoadingState());

    try {
      UserModal userModal =
          await _userRepo.createAccount(email: email, password: password);
      _emitLoggedInState(
          userModal: userModal, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void updateUser(UserModal userModal) async {
    // emit(UserLoadingState());
    try {
      // print("hello world");
      UserModal updatedUser = await _userRepo.updateUser(userModal);
      emit(UserLoggedInState(updatedUser));
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signOut() async {
    await Preferences.clear();
    emit(UserLoggedOutState());
  }
}
