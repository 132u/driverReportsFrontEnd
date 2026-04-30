import 'package:flutter/material.dart';
import '../core/api/auth_service.dart';
import '../core/storage/token_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = AuthService();
  final tokenStorage = TokenStorage();

  void login() async {
    final token = await authService.login(
      emailController.text,
      passwordController.text,
    );

    if (token != null) {
      await tokenStorage.saveToken(token);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print("Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController, obscureText: true),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}