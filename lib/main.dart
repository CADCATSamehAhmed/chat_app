import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:chat_app/features/splash/presentation/views/splash_view.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/constants/variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/presentation/views/signup_view.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/chat/presentation/view_model/chat_cubit.dart';
import 'features/home/presentation/view_model/home_cubit.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final user = FirebaseAuth.instance.currentUser;
  uid = user?.uid??'z7hbnnp8U1Ufh9oGRD9lXWjCN8Z2';
  // HomeRepo homeRepo = HomeRepo();
  // await homeRepo.setupUserPresence(uid??'z7hbnnp8U1Ufh9oGRD9lXWjCN8Z2');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // uid = CacheHelper.getData(key: 'uid')??'UugIMiy3BrTW7vaKSIqGz78CshC3';//ahmed
    // uid = CacheHelper.getData(key: 'uid')??'rHmqbxOsYWVDfv5zmJ8h37dD82M2';//omer
    // uid = CacheHelper.getData(key: 'uid')??'z7hbnnp8U1Ufh9oGRD9lXWjCN8Z2';//sameh
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => StatusCubit()),
        BlocProvider(create: (context) => ProfileCubit()..getUserData()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner :false,
        title: 'Chat App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/':(context)=>const SplashView(),
          'login':(context)=>const LoginScreen(),
          'signup':(context)=>const SignUpScreen(),
          'home':(context)=>const HomeView(),
          'profile':(context)=>const ProfileView(),
        },
      ),
    );
  }
}

