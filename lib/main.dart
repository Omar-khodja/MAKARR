import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/navigation_screen.dart';
import 'package:makarr/feature/auth/presentation/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue.shade900,
).copyWith();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.clearPersistence();
  await dotenv.load(fileName: 'assets/config/.env');
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
    debug: true,
  );
  FirebaseFirestore.instance.settings = const Settings(
    cacheSizeBytes: 50 * 1024 * 1024, // 50 MB
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String? _lastFetchedUid;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
              final user = snapshot.data;

              if (user != null) {
                if (_lastFetchedUid != user.uid) {
                  _lastFetchedUid = user.uid;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    ref
                        .read(userNotifireProvider.notifier)
                        .featchCurrentUser(user.uid);
                  });
                }
                return const NavigationScreen();
              }

              _lastFetchedUid = null;
              return const Login();
            },
          ),
        );
      },
    );
  }
}
