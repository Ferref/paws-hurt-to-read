import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/main.dart';

import 'package:frontend/views/registration_view.dart';
import 'package:frontend/views/main_home_view.dart';
import 'package:frontend/viewmodels/session_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;

  final sessionVm = getIt<SessionViewModel>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.paw, color: Colors.white, size: 48),
              const SizedBox(height: 20),
              const Text(
                'PawsHurtToRead',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sign In to continue',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.normal, fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 26),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  errorText: errorMessage,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await sessionVm.store(_usernameController.text, _passwordController.text);

                      if (!context.mounted) {
                        return;
                      }
                                   
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainHomeView()),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login successful! Welcome, ${user.name}')),
                        );
                      }
                    } catch (e) {
                      if (e.toString().contains('Validation errors')) {
                        final errors = jsonDecode(
                          e.toString().replaceFirst('Exception: Validation errors: ', ''),
                        )["errors"];
                        setState(() {
                          errorMessage = errors['message']?[0];
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed... Please try again later')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              const Center(
                child: Text(
                  // TODO: password recovery view
                  // TODO: password recovery implementation
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationView())),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white),
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