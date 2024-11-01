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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ThemeData theme = Theme.of(context);
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        AuthCubit.get(context).checkState(state);
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthLogo(size: 250.w),
                  SizedBox(height: 10.h),
                  Text(
                    'Log in to your account',
                    style: Fonts.font23.copyWith(color: theme.primaryColorDark),
                  ),
                  SizedBox(height: 10.h),
                  EmailField(emailController: emailController),
                  SizedBox(height: 10.h),
                  PasswordField(
                      passwordController: passwordController,
                      toggleVisibility: cubit.changePasswordVisible,
                      isPasswordVisible: cubit.obscurePassword),
                  SizedBox(height: 20.h),
                  AuthButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          defaultLoading(
                              context: context,
                              asyncFunction: cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text));
                        }
                      },
                      text: 'Log In'),
                  SizedBox(height: 10.h),
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
