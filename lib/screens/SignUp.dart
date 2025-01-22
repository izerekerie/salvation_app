import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    hintText: 'Enter username',
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                    hintText: 'Confirm password',
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
                    onPressed: regitser,
                    child: Text(
                      'Sign Up',
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
                Text('Already registered?'),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(context, '/login'),
                  child: Text(
                    'Sign In',
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

  Future<void> regitser() async {
    print('here registering ');
    final url = 'https://41a5-37-19-200-115.ngrok-free.app/auth/register';
    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;
    final confirmPassword = confirmPasswordController.text;

    final body = {
      "email": email,
      "password": password,
      "username": username,
      'confirmPassword': confirmPassword
    };
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: body);
    try {
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);

        Navigator.of(context).pushNamed('/login');
      } else {
        print('error from ${response.reasonPhrase}');
      }
    } catch (error) {
      print('error  ${response.reasonPhrase}');
    }
  }
}
