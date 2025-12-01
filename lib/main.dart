import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/screen/home_with_nav.dart';
import 'package:makarr/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// MAKARR Color Palette (Light Theme)

const Color kPrimaryColor = Color(0xFF0078C8); // Main blue
const Color kSecondaryColor = Color(0xFF5BB3F0); // Light blue
const Color kAccentDark = Color(0xFF0A2A43); // Dark blue
const Color kTextGray = Color(0xFF333333); // Primary text
const Color kWhite = Color(0xFFFFFFFF); // White

final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0078C8));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
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
        colorScheme: colorScheme,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeWithNav(uId: snapshot.data!.uid);
          }
          return const Login();
        },
      ),
    );
  }
}
