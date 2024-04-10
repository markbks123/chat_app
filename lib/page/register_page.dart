import 'package:chat_app/component/button/my_button.dart';
import 'package:chat_app/component/my_text_field.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    print(passwordController.text);
    print(confirmPasswordController.text);
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password not match")));
      return;
    }

    final authServices = Provider.of<AuthServices>(context, listen: false);

    try {
      await authServices.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: 200,
                  height: 200,
                  'assets/images/discuss.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Create an account",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'confirm password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(onTap: signUp, text: "Sign In"),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?"),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
