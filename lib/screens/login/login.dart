import 'package:flutter/material.dart';
import 'package:movie_app/screens/login/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  Future<SharedPreferences>? _prefs;

  @override
  void initState() {
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

  getUsername() async {
    final pref = await _prefs;
    final username = pref?.getString('username');
    if (username != null) {
      _usernameController?.text = username;
    }
  }

  signOut() async {
    final pref = await _prefs;
    pref?.remove('username');
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
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    getUsername();
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
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
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
              TextButton(
                onPressed: () {
                  signOut();
                },
                child: const Text('Forgot password?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
