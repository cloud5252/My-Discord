import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_discord/app/app.bottomsheets.dart';
import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/firebase_options.dart';
import 'package:my_discord/models/hive_user_model.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init('');

  Hive.registerAdapter(HiveUserModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());

  await Hive.openBox<HiveUserModel>('friends_box');
  await Hive.openBox<HiveUserModel>('current_user_box');
  await Hive.openBox<MessageModel>('messages_box');
  await Hive.openBox('prefs_box');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  await FirebaseAuth.instance.authStateChanges().first;

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _DiscordScrollBehavior(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundDartMode,
          colorScheme: const ColorScheme.dark(
            surface: backgroundDartMode,
          ),
          textTheme: GoogleFonts.notoSansTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [StackedService.routeObserver],
      ),
    );
  }
}

class _DiscordScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad,
      };

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
