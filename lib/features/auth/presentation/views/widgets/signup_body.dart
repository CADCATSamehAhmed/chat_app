import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_logo.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/name_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        AuthCubit.get(context).checkState(state);
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthLogo(
                      size: 180.w,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Register To New Account',
                      style: Fonts.font23
                          .copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(height: 10.h),
                    NameField(nameController: nameController),
                    SizedBox(height: 10.h),
                    EmailField(emailController: emailController),
                    SizedBox(height: 10.h),
                    PhoneField(phoneController: phoneController),
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
                                asyncFunction: cubit.signUp(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text));
                          }
                        },
                        text: 'Sign Up'),
                    SizedBox(height: 10.h),
                    const AuthFooter(
                        longText: "Already have an account?",
                        shortText: "Login here",
                        navigateBack: true)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
