import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:makarr/screen/profile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: .light,
        textTheme: GoogleFonts.fjordOneTextTheme(ThemeData.light().textTheme),

        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFF1B7C86),
          seedColor: const Color(0xFF1B7C86),
          secondary: const Color(0xFF788888),
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder:(context, snapshot) {
        if(snapshot.hasData){
          return const Profile();
        }
        return const Login();
      },),
    );
  }
}
