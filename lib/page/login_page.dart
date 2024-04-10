import 'package:chat_app/component/button/my_button.dart';
import 'package:chat_app/component/my_text_field.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void sigIn() async {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    try {
      await authServices.signInWithEmailandPassword(
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
                  "Login an account",
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
                  height: 25,
                ),
                MyButton(onTap: sigIn, text: "Sign Up"),
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
                        "Register now",
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
