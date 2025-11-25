import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/controller/custom_TextFormField.dart';
import 'package:makarr/screen/createAccounte.dart';
import 'package:makarr/widget/outLineButton.dart';
import 'package:makarr/widget/primaryButton.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    "Login with email",
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
                TextFormField(
                  controller: _passwordController,
                  obscureText: !showPassword,

                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),

                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "Password must be at  least 6 characters! ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: .end,
                  children: [
                    Text(
                      "forgot  password? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                PrimaryButton(
                  label: "Singin",
                  fun: _submit,
                  tailIcon: Icons.login,
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Sing in with social media",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                OutLineButton(
                  text: "Sing in with Google",
                  fun: () {},
                  image: "assets/logo/google.png",
                ),
                const SizedBox(height: 10),

                OutLineButton(
                  text: "Sing in with Facebook",
                  fun: () {
                    AppLogger.i("information logger");
                    AppLogger.d("debug logger");
                    AppLogger.e("error logger");
                    AppLogger.w("worning logger");
                    AppLogger.w("wtf logger");
                  },
                  image: "assets/logo/facebook.png",
                ),
                const SizedBox(height: 20),

                Text.rich(
                  TextSpan(
                    text: "Not a member , ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: "Create a new accounte",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateAccounte(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final bool isValid = _formkey.currentState!.validate();
    if (!isValid) return;
    print(_emailController.text);
    print(_passwordController.text);
  }
}
