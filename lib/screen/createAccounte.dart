import 'package:flutter/material.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/controller/custom_TextFormField.dart';
import 'package:makarr/screen/login.dart';
import 'package:makarr/widget/outLineButton.dart';
import 'package:makarr/widget/primaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;

class CreateAccounte extends StatefulWidget {
  const CreateAccounte({super.key});

  @override
  State<CreateAccounte> createState() => _CreateAccounteState();
}

class _CreateAccounteState extends State<CreateAccounte> {
  final _formkey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Center(
                  child: Image.asset(
                    "assets/logo/logo.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Center(
                  child: Text(
                    "Create accounte",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 5,
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _fullNameController,
                  label: "Full name",
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().length < 4) {
                      return "name must be at least 4 character!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _birthDateController,
                  label: "Birth date",
                  icon: Icons.calendar_month_outlined,
                  inputType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.trim() == "") {
                      return "Please enter your birth date ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _emailController,
                  label: "Enter your email",
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains("@")) {
                      return "Pealse enter valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _password1Controller,
                  label: "Enter your password",
                  icon: Icons.lock,
                  inputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "Password must be at  least 6 characters! ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _password2Controller,
                  label: "Enter your password",
                  icon: Icons.lock,
                  inputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "Password must be at  least 6 characters! ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: "Create accounte",
                  fun: _submit,
                  tailIcon: Icons.arrow_forward_rounded,
                ),
                const SizedBox(height: 10),
                OutLineButton(
                  text: "Login page",
                  fun: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  ),
                  leadIcon: Icons.arrow_back,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    final bool isValid = _formkey.currentState!.validate();
    if (!isValid) return;
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _password1Controller.text,
      );
      _firebaseAuth.
      AppLogger.i(userCredential.toString(), className: runtimeType.toString());
    } on FirebaseAuthException catch (e) {
      String error;
      switch (e.code) {
        case "email-already-in-use":
          error = "email already in use";
          break;
        case "invalid-email":
          error = "invalid-email";
          break;
        case "network-request-failed":
          error = "check your internet connection";
          break;
        default:
          error = e.message ?? "somthing went wornge please try again later";
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }
}
