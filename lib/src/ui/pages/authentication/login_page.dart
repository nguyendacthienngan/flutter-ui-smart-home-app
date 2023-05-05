
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home/src/ui/pages/authentication/components/my_button.dart';
import 'package:flutter_smart_home/src/ui/pages/authentication/components/square_tile.dart';

import 'components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Sign user in method
  void signUserIn() async {
    // Show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      // pop the loading circle
      Navigator.pop(context);
      wrongEmailOrPasswordMessage();
    }
  }

  void wrongEmailOrPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  'Incorrect email or password',
                  style: TextStyle(color: Colors.white),
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

                // Welcome back
                Text(
                    'Welcome back, you\'ve been missed',
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

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                MyButton(
                  dataText: "Sign in",
                  onTap: signUserIn
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

                // Not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a meber?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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