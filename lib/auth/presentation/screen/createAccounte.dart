import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/auth/presentation/controler/authNotifire.dart';
import 'package:makarr/auth/presentation/component/custom_TextFormField.dart';
import 'package:makarr/core/component/outLineButton.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/auth/domain/entities/user_auth.dart';
import 'package:makarr/core/data/algeria_cites.dart';

class CreateAccounte extends ConsumerStatefulWidget {
  const CreateAccounte({super.key});

  @override
  ConsumerState<CreateAccounte> createState() => _CreateAccounteState();
}
//// TODO minimaize this class

class _CreateAccounteState extends ConsumerState<CreateAccounte> {
  final _formkey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  late List<String> wilaya;
  late List<String> bladia;
  String? selectedWilaya;
  String? selectedBladya;
  @override
  void initState() {
    super.initState();
    wilaya = algeriacites
        .map((e) {
          return (e["wilaya_name"] as String);
        })
        .toSet()
        .toList();
    selectedWilaya = wilaya.first;
    setBaladya();
  }

  void setBaladya() {
    bladia = algeriacites
        .where((value) => value["wilaya_name"] as String == selectedWilaya)
        .map((e) => e["daira_name"] as String)
        .toSet()
        .toList();
    selectedBladya = bladia.first;
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _phoneNumberController.dispose();
    _lNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _password1Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifireProvider);
    ref.listen(authNotifireProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    });
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
                DropdownButtonFormField<String>(
                  initialValue: selectedWilaya,
                  hint: const Text("Select Wilaya"),
                  decoration: const InputDecoration(
                    label: Text("Select Wilaya"),
                  ),
                  items: wilaya
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedWilaya = value!;
                      setBaladya();
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: selectedBladya,
                  hint: const Text("Select Bladya"),
                  decoration: const InputDecoration(
                    label: Text("Select Bladya"),
                  ),
                  items: bladia
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBladya = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: "Create accounte",
                  fun: _submit,
                  tailIcon: Icons.arrow_forward_rounded,
                  isLoading: auth.isLoading,
                ),
                const SizedBox(height: 10),
                OutLineButton(
                  text: "Login page",
                  fun: () => Navigator.pop(context),
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
    final auth = ref.read(authNotifireProvider.notifier);
    if (!isValid) return;

    await auth.createUser(
      UserAuth(
        firstName: _fNameController.text.trim(),
        lastName: _lNameController.text.trim(),
        phone: _phoneNumberController.text.trim(),
        email: _emailController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        password: _password1Controller.text.trim(),
        wilaya: selectedWilaya!,
        bladya: selectedBladya!,
      ),
    );
    if (!mounted) return;
    Navigator.pop(context);
    
  }
}
