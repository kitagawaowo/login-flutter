import 'package:flutter/material.dart';
import 'package:movie_app/screens/login/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XtremeMovie'),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed:() {
            Navigator.push(context,MaterialPageRoute(builder:(context) {
              return const Login();
            },));
          },
          child: const Text("Movies"),
        ),
      ),
    );
  }
}
