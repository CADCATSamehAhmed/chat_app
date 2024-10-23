import 'package:chat_app/core/constants/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeNavBarIndexState extends HomeStates {}

class LogoutLoadingState extends HomeStates {}

class LogoutSuccessState extends HomeStates {}

class LogoutErrorState extends HomeStates {}

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit? _homeCubit;
  int currentIndex = 0;

  static HomeCubit get(context) {
    _homeCubit ??= BlocProvider.of(context);
    return _homeCubit!;
  }

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarIndexState());
  }

  Future<void> logOut() async {
    emit(LogoutLoadingState());
    try{
      await FirebaseAuth.instance.signOut();
      // await CacheHelper.removeData(key: 'uid');
      uid = null;
      currentIndex = 0;
      Get.offAllNamed('login');
      emit(LogoutSuccessState());
    }catch(error){
      print('logout error:$error');
      emit(LogoutErrorState());
    }
  }
}
