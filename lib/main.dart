import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/provider/user_Provider.dart';
import 'package:makarr/screen/home_with_nav.dart';
import 'package:makarr/auth/presentation/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue.shade900,
).copyWith();

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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = colorScheme;
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue.shade900,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: .light,
            textTheme: GoogleFonts.fjordOneTextTheme(
              ThemeData.light().textTheme,
            ),
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            brightness: .dark,
            textTheme: GoogleFonts.fjordOneTextTheme(
              ThemeData.dark().textTheme,
            ),
            colorScheme: darkColorScheme,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                ref
                    .read(userProvider.notifier)
                    .fetchUserInfo(snapshot.data!.uid);
                return HomeWithNav(uId: snapshot.data!.uid);
              }
              return const Login();
            },
          ),
        );
      },
    );
  }
}
