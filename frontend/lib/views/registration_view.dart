import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/viewmodels/registration_view_model.dart';
import 'package:frontend/main.dart';
import 'main_home_view.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  RegistrationViewState createState() => RegistrationViewState();
}

class RegistrationViewState extends State<RegistrationView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final vm = getIt<RegistrationViewModel>();

  String? emailError;
  String? usernameError;
  String? passwordError;
  String? passwordConfirmationError;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
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
                'Create an account to continue',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.normal, fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 26),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(), errorText: usernameError),
              ),
              const SizedBox(height: 26),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(), errorText: emailError),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(), errorText: passwordError),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordConfirmationController,
                decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(), errorText: passwordConfirmationError),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await vm.store(
                        _usernameController.text,
                        _emailController.text,
                        _passwordController.text,
                        _passwordConfirmationController.text,
                      );

                      if (!context.mounted) {
                        return;
                      }
                      
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainHomeView()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration successful! Welcome, ${user.name}')),
                        );
                      }
                    } catch (e) {
                      if (e.toString().contains('Validation errors')) {
                        final errors = jsonDecode(
                          e.toString().replaceFirst('Exception: Validation errors: ', ''),
                        )["errors"];
                        setState(() {
                          emailError = errors['email']?[0];
                          usernameError = errors['name']?[0];
                          passwordError = errors['password']?[0];
                          passwordConfirmationError = errors['password_confirmation']?[0];
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration failed... Please try again later')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Registration',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Sign In",
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