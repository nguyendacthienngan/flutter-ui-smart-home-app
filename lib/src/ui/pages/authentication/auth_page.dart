
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_home/src/ui/pages/home_page.dart';
import 'package:flutter_smart_home/src/ui/pages/authentication/login_page.dart';

import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return const HomePage();
          } else {
          // User is NOT logged in
            return const LoginOrRegisterPage();
          }
        },

      ),
    );
  }

}