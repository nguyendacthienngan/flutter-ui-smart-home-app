
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/ui/pages/authentication/components/my_button.dart';
import 'package:flutter_smart_home/src/ui/pages/authentication/components/square_tile.dart';

import 'components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // Sign user up method
  void signUserUp() async {
    // Show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    // try creating the user
    try {

      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      } else {
        // Show error message, password don't match
        errorMessage("Passwords don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      // pop the loading circle
      Navigator.pop(context);
      errorMessage(e.message);
    }
  }

  void errorMessage(text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              )
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                Image.asset("assets/images/logo.png", height: 100),

                const SizedBox(height: 30),

                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 30),

                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 5),

                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 5),

                // Password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 30),

                MyButton(
                    dataText: "Sign up",
                    onTap: signUserUp
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: "assets/images/google.png"),

                    SizedBox(width: 10),

                    // apple button
                    SquareTile(imagePath: "assets/images/apple.png"),
                  ],
                ),

                const SizedBox(height: 30),

                // Sing in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have a account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}