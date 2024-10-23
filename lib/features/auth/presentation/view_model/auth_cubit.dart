import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/cache_helper.dart';
import 'package:chat_app/core/shared_widgets/default_snack_bar.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class ChangePasswordVisibleState extends AuthStates {}
class AuthLoadingState extends AuthStates {}
class AuthSuccessState extends AuthStates {}
class LoginErrorWrongPasswordState extends AuthStates {}
class LoginErrorUserNotFoundState extends AuthStates {}
class SignupErrorWeakPasswordState extends AuthStates {}
class SignupErrorEmailAlreadyInUseState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;

  AuthErrorState(this.error);
}


class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  AuthRepo authRepo = AuthRepo();
  bool obscurePassword = true;

  void changePasswordVisible() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibleState());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    var statusCode = await authRepo.login(email: email, password: password);
    if (statusCode == 200) {
      uid=authRepo.uid;
      CacheHelper.saveData(key: 'uid', value: authRepo.uid);
      Get.offNamed('home');
      emit(AuthSuccessState());
    } else if (statusCode == 400) {
      emit(LoginErrorWrongPasswordState());
    } else if (statusCode == 401) {
      emit(LoginErrorUserNotFoundState());
    } else {
      emit(AuthErrorState(authRepo.error));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoadingState());
    await authRepo.signUp(email: email, password: password, name: name, phone: phone).then((
        statusCode) {
      if (statusCode == 200) {
        uid=authRepo.uid;
        CacheHelper.saveData(key: 'uid', value: authRepo.uid);
        Get.offNamed('home');
        emit(AuthSuccessState());
      } else if (statusCode == 402) {
        emit(SignupErrorWeakPasswordState());
      } else if (statusCode == 403) {
        emit(SignupErrorEmailAlreadyInUseState());
      } else {
        emit(AuthErrorState(authRepo.error));
      }
    });
  }

  void checkState(AuthStates state) {
    if (state is LoginErrorUserNotFoundState) {
      defaultSnackBar(message: 'There is no account by this email');
    } else if (state is LoginErrorWrongPasswordState) {
      defaultSnackBar(message: 'Password is not correct');
    } else if (state is SignupErrorEmailAlreadyInUseState) {
      defaultSnackBar(message: 'The email provided is already used');
    } else if (state is SignupErrorWeakPasswordState) {
      defaultSnackBar(message: 'The password provided is too weak');
    } else if (state is AuthErrorState) {
      defaultSnackBar(message: 'Sorry something went wrong');
    }
  }
}
