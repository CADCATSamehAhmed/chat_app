import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_logo.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        AuthCubit.get(context).checkState(state);
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: screenWidth * .05,
                children: [
                  AuthLogo(size: screenWidth * .7),
                  Text(
                    'Log in to your account',
                    style: Fonts.font23,
                  ),
                  EmailField(emailController: emailController),
                  PasswordField(
                      passwordController: passwordController,
                      toggleVisibility: cubit.changePasswordVisible,
                      isPasswordVisible: cubit.obscurePassword),
                  AuthButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          defaultLoading(
                              asyncFunction: cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text));
                        }
                      },
                      text: 'Log In'),
                  const AuthFooter(
                    longText: "Don't have an account?",
                    shortText: "Register here",
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
