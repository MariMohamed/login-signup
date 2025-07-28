import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/manager/theme/app_drawerStateManager.dart';
import 'package:login_signin/core/manager/theme/app_theme.dart';
import 'package:login_signin/core/manager/theme/app_themeSwitcher.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/login.dart';
import 'package:login_signin/presentation/features/signup.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            routes: <String, WidgetBuilder>{
              '/Sign Up': (context) => SignUp(),
              '/login': (context) => LogIn(),
              '/home': (context) => HomeScreen(),
            },
            //initialRoute: Routes.logIn,
            initialRoute: Routes.home,
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
