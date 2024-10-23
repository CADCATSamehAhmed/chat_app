import 'package:chat_app/core/constants/variables.dart';
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
      child:
          BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        AuthCubit.get(context).checkState(state);
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: screenWidth * .05,
                  children: [
                    AuthLogo(
                      size: screenWidth * .5,
                    ),
                    Text(
                      'Register To New Account',
                      style: Fonts.font23,
                    ),
                    NameField(nameController: nameController),
                    EmailField(emailController: emailController),
                    PhoneField(phoneController: phoneController),
                    PasswordField(
                        passwordController: passwordController,
                        toggleVisibility: cubit.changePasswordVisible,
                        isPasswordVisible: cubit.obscurePassword),
                    AuthButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            defaultLoading(
                                asyncFunction: cubit.signUp(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: passwordController.text,
                                    password: passwordController.text));
                          }
                        },
                        text: 'Sign Up'),
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
