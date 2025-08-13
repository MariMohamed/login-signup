import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/firebase/firebase_setup.dart';
import 'package:login_signin/core/manager/shared_preferences_manager.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/providers/app_drawerStateManager.dart';
import 'package:login_signin/core/manager/theme/app_theme.dart';
import 'package:login_signin/core/providers/app_themeSwitcher.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:login_signin/presentation/features/auth/signup.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider<DrawerStateInfo>(
          create: (_) => DrawerStateInfo(),
        ),
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
