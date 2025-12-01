import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/provider/user_Provider.dart';
import 'package:makarr/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:makarr/screen/profile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifire = ref.watch(userProvider.notifier);

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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder(
              future: userNotifire.fetchUserInfo(snapshot.data!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                  return const Profile();
                

              },
            );
          }
          return const Login();
        },
      ),
    );
  }
}
