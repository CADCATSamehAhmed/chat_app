import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/cache_helper.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

abstract class HomeStates {}
class HomeInitialState extends HomeStates {}
class ChangeNavBarIndexState extends HomeStates {}
class AppChangModeState extends HomeStates {}
class LogoutLoadingState extends HomeStates {}
class LogoutSuccessState extends HomeStates {}
class LogoutErrorState extends HomeStates {}

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit? _homeCubit;
  int currentIndex = 0;
  bool modeIsLight = CacheHelper.getData(key: 'appMode')??true;
  ThemeMode appMode = CacheHelper.getData(key: 'appMode')??true?ThemeMode.light:ThemeMode.dark;

  static HomeCubit get(context) {
    _homeCubit ??= BlocProvider.of(context);
    return _homeCubit!;
  }

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarIndexState());
  }
  // Change application mode state
  void changeAppMode() {
    modeIsLight = !modeIsLight;
    appMode = modeIsLight?ThemeMode.light:ThemeMode.dark;
    CacheHelper.putBoolean(key: 'appMode', value: modeIsLight);
    emit(AppChangModeState());
  }

  Future<void> logOut() async {
    emit(LogoutLoadingState());
    try{
      await FirebaseAuth.instance.signOut();
      await CacheHelper.removeData(key: 'uid');
      uid = null;
      currentIndex = 0;
      Get.offAll(()=> const LoginView());
      emit(LogoutSuccessState());
    }catch(error){
      emit(LogoutErrorState());
      rethrow;
    }
  }
  void onUserLogin(BuildContext context) {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 507639728 ,
      appSign: '4927a8c447ea5245ff61a6cfe57e62018b3e7e363ec119b486301356be8fdb87',
      userID: uid!,
      userName: uid!,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
  void onUserLogout() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
