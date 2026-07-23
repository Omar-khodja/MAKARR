import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/pymente/presentation/controler/subscriptionnotifire.dart';
import 'package:makarr/navigation_screen.dart';
import 'package:makarr/feature/auth/presentation/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue.shade900,
).copyWith(secondary: Colors.deepPurple, surface: Colors.grey.shade100);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await firestore.FirebaseFirestore.instance.clearPersistence();
  await dotenv.load(fileName: 'assets/config/.env');
  AwesomeNotifications().initialize(
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
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
    debug: true,
  );
  firestore.FirebaseFirestore.instance.settings = const firestore.Settings(
    cacheSizeBytes: 50 * 1024 * 1024, // 50 MB
  );

  mapbox.MapboxOptions.setAccessToken(dotenv.env['ACCESS_TOKEN']!);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
            textTheme:
                GoogleFonts.fjordOneTextTheme(
                  ThemeData.light().textTheme,
                ).copyWith(
                  titleLarge: GoogleFonts.fjordOne(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // adjust to match your scheme
                  ),
                  titleMedium: GoogleFonts.fjordOne(
                    color: Colors.white, // adjust to match your scheme
                  ),
                ),
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            brightness: .dark,
            textTheme: GoogleFonts.fjordOneTextTheme(ThemeData.dark().textTheme)
                .copyWith(
                  titleLarge: GoogleFonts.fjordOne(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // adjust to match your scheme
                  ),
                  titleMedium: GoogleFonts.fjordOne(
                    color: Colors.white, // adjust to match your scheme
                  ),
                ),
            colorScheme: darkColorScheme,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final user = snapshot.data;

              if (user != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(userNotifireProvider.notifier)
                      .featchCurrentUser(user.uid);
                  ref
                      .read(subscriptionProvider.notifier)
                      .checkSubscription(user.uid);
                });

                return const NavigationScreen();
              }

              return const Login();
            },
          ),
        );
      },
    );
  }
}
