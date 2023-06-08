import 'package:flutter/material.dart';
import 'package:movie_app/data/http_helper.dart';
import 'package:movie_app/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  HttpHelper? _httpHelper;
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  User? _user;
  Future<SharedPreferences>? _prefs;

  @override
  void initState() {
    _httpHelper = HttpHelper();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _prefs = SharedPreferences.getInstance();
    getUsername();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  createUser() async {
    _user = await _httpHelper!
        .createUser(_usernameController!.text, _passwordController!.text);
    final pref = await _prefs;
    await pref?.setString('username', _user!.username);
  }

  getUsername() async {
    final pref = await _prefs;
    final username = pref?.getString('username');
    if (username != null) {
      _usernameController?.text = username;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipOval(
              child: Image.asset(
                'assets/login.jpg',
                height: size.height * 0.35,
              ),
            ),
          ),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                filled: true,
                fillColor: Theme.of(context).secondaryHeaderColor,
                prefixIcon: const Icon(
                  Icons.person,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                hintText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
                decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                filled: true,
                fillColor: Theme.of(context).secondaryHeaderColor,
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                suffixIcon: const Icon(
                  Icons.visibility
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                hintText: 'Password'),
          ),
          OutlinedButton(
            onPressed: () {
              getUsername();
            },
            child: const Text('Sign in'),
          ),
          OutlinedButton(
            onPressed: () {
              createUser();
            },
            child: const Text('Sign up'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Forgot password'),
          )
        ],
      ),
    );
  }
}
