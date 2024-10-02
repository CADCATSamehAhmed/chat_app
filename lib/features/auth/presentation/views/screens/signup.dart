import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth%20_footer.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_form_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_logo.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: screenWidth*.05,
              children: [
                AuthLogo(size: screenWidth*.5,),
                Text(
                  'Register To New Account',
                  style: Fonts.font23,
                ),
                AuthFormFiled(
                  context: context,
                  controller: nameController,
                  type: TextInputType.name,
                  obscureText: false,
                  label: 'enter your name',
                  validate: (s) {
                    return null;
                  },
                  prefixIcon: Icons.person,
                  suffixIcon: null,
                ),
                AuthFormFiled(
                  context: context,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  obscureText: false,
                  label: 'enter your email',
                  validate: (s) {
                    return null;
                  },
                  prefixIcon: Icons.email,
                  suffixIcon: null,
                ),
                AuthFormFiled(
                  context: context,
                  controller: phoneController,
                  type: TextInputType.phone,
                  obscureText: false,
                  label: 'enter your phone',
                  validate: (s) {
                    return null;
                  },
                  prefixIcon: Icons.phone_android,
                  suffixIcon: null,
                ),
                AuthFormFiled(
                  context: context,
                  controller: passwordController,
                  type: TextInputType.text,
                  obscureText: true,
                  label: 'enter your password',
                  validate: (s) {
                    return null;
                  },
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                ),
                AuthButton(
                    context: context, onPressed: () {}, text: 'Sign Up'),
                const AuthFooter(
                    longText: "Already have an account?",
                    shortText: "Login here",
                    navigateTo: 'login')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
