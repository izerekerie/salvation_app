import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:salvation_app/utils/getToken.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TokenManager _tokenManager = TokenManager();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: 'Enter email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: 'Enter password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: TextButton(
                    onPressed: login,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text('Not yet Registered'),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(context, '/signup'),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    print("Login button pressed");
    final url = 'https://41a5-37-19-200-115.ngrok-free.app/auth/login';
    final email = emailController.text;
    final password = passwordController.text;

    final body = {"email": email, "password": password};
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: body);
    try {
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final token = json['access_token'] as String;
        _tokenManager.saveToken(token);
        Navigator.of(context).pushNamed('/home');
      }
    } catch (error) {
      print(error);
    }
  }
}
