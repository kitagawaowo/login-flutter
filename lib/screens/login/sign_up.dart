import 'package:flutter/material.dart';
import 'package:movie_app/data/http_helper.dart';
import 'package:movie_app/data/user.dart';
import 'package:movie_app/screens/movie/movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  navigateTo({required Widget widget}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        ((route) => false));
  }

  createUser() async {
    _user = await _httpHelper!
        .createUser(_usernameController!.text, _passwordController!.text);

    if (_user != null) {
      final pref = await _prefs;
      await pref?.setString('username', _user!.username);
      navigateTo(widget: const Movies());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
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
                ),
              ),
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Password'),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Password'),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    createUser();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Sign up'),
                ),
              ),
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Sign in'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
