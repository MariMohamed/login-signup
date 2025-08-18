import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/hive/hive_setup.dart';
import 'package:login_signin/core/manager/shared_preferences_manager.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/providers/app_drawerStateManager.dart';
import 'package:login_signin/core/manager/theme/app_theme.dart';
import 'package:login_signin/core/providers/app_themeSwitcher.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:login_signin/presentation/features/auth/signup.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveSetup.init();
  await SharedPreferencesManager.init();
  await FastCachedImageConfig.init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageManager>(create: (_) => ImageManager()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<AppDataProvider>(
          create: (context) => AppDataProvider()..loadData(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            routes: <String, WidgetBuilder>{
              '/Sign Up': (context) => SignUp(),
              '/login': (context) => LogIn(),
              '/home': (context) => HomeScreen(),
            },
            initialRoute: Routes.logIn,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
