import 'package:flutter/material.dart';
import 'package:flutter_application_1/router/route_constants.dart';
import 'package:flutter_application_1/utils/user_secure_storage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            UserSecureStorage.deleteAllData();
            Navigator.pop(context);
            Navigator.pushNamed(context, homeRoute);
          },
          child: const Text('Выйти',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
