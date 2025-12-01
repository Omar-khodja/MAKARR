import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _fNameController = TextEditingController();
  final _idController = TextEditingController();
  final _lNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _fNameController.dispose();
    _idController.dispose();
    _phoneNumberController.dispose();
    _lNameController.dispose();
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
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: 5,
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextformfield(
                  controller: _fNameController,
                  label: "First name",
                  icon: Icons.person_outline,
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().length < 4) {
                      return "First name must be at least 4 character!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextformfield(
                  controller: _lNameController,
                  label: "Last name",
                  icon: Icons.person_outline,
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().length < 4) {
                      return "Last name must be at least 4 character!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextformfield(
                  controller: _phoneNumberController,
                  label: "Phone number",
                  icon: Icons.phone_outlined,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return "Phone number must be 10 numbers!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextformfield(
                  controller: _idController,
                  label: "ID number",
                  icon: Icons.badge_outlined,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().length < 16) {
                      return "ID must be 16 numbers!";
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
                  icon: Icons.email_outlined,
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
                  icon: Icons.lock_outline,
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
                  label: "Confirm your password",
                  icon: Icons.lock_outline,
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
                  isLoading: isLoading,
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
    setState(() {
      isLoading = true;
    });
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _password1Controller.text,
      );
      if (userCredential.user == null) return;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
            'UserId': _idController.text.trim(),
            'Fname': _fNameController.text.trim(),
            'Lname': _lNameController.text.trim(),
            'Phone': _phoneNumberController.text.trim(),
            'Birth_Date': _birthDateController.text.trim(),
            'Email': _emailController.text.trim(),
            'Password': _password1Controller.text.trim(),
            'ImagUrl': "",
          });

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const Login()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;
      AppLogger.e(
        className: runtimeType.toString(),
        " ${e.message} ,${e.code}",
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "somthing went worng please try again later",
          ),
        ),
      );
    }
  }
}
