import 'package:chat_app/core/themes/dark_theme.dart';
import 'package:chat_app/core/themes/light_theme.dart';
import 'package:chat_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'core/constants/variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/shared_prefences/bloc_observer.dart';
import 'core/shared_prefences/cache_helper.dart';
import 'features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  uid = CacheHelper.getData(key: 'uid');
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    // HomeRepo homeRepo = HomeRepo();
    // await homeRepo.setupUserPresence(uid??'z7hbnnp8U1Ufh9oGRD9lXWjCN8Z2');
    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return BlocConsumer<HomeCubit, HomeStates>(
              builder: (context, state) {
                return GetMaterialApp(
                  navigatorKey: widget.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Chat App',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: HomeCubit.get(context).appMode,
                  home: const SplashView(),
                );
              },
              listener: (context, state) {},
            );
          }),
    );
  }
}
