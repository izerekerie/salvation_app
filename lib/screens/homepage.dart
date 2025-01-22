import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salvation_app/models/User.dart';
import 'package:salvation_app/utils/getToken.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TokenManager _tokenManager = TokenManager();
  String? token;
  List<User> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? storedToken = await _tokenManager.getToken();

    setState(() {
      token = storedToken;
    });
  }

  Future<List<User>> fetchBattles() async {
    final url = 'https://41a5-37-19-200-115.ngrok-free.app/users/';

    final uri = Uri.parse(url);
    try {
      print('here fetching users');
      final response = await http.get(uri,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body.toString());

        for (Map<String, dynamic> item in data) {
          users.add(User.fromJson(item));
        }
        return users;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: fetchBattles(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      '$index ${users[index].username}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
