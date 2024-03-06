// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_friend/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  final Auth auth;

  const LoginWidget({Key? key, required this.auth}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future<void> _login() async {
    setState(() {
    });
    try {
      await widget.auth.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      // Navigate to home screen
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              key: Key("Invalid email or password"),
              content: Text('Invalid email or password')),
        );
      }
    } finally {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: const Key("Login Page"),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E2E2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.grey,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  children: [
                    TextSpan(
                      text: 'Fit',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jost',
                        fontSize: 30,
                      ),
                    ),
                    TextSpan(
                      text: 'Friend',
                      style: TextStyle(
                        color: Color(0xFFF54242),
                        fontFamily: 'Jost',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: const Color(0xFFE2E2E2),
                // Set color of Material widget here
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: TextFormField(
                          key: const Key("email_input"),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value!)) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          key: const Key("password_input"),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        key: const Key("login_button"),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF54242),
                          // Set button color here
                          minimumSize:
                              const Size(200, 50), // Set button size here
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: TextButton(
                              onPressed: () {
                                // Navigate to forgot password screen
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  )),
                              const SizedBox(width: 4.0),
                              TextButton(
                                onPressed: () {
                                  // Navigate to sign up screen
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
