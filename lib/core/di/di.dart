import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:login_signin/core/connection/networkInfo.dart';
import 'package:login_signin/core/firebase/auth.dart';
import 'package:login_signin/core/hive/hive_setup.dart';
import 'package:login_signin/core/manager/shared_preferences_manager.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/remote/api_service.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  await HiveSetup.init();
  await Firebase.initializeApp();
  await SharedPreferencesManager.init();
  await FastCachedImageConfig.init();
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  //Register Firebase
  sl.registerLazySingleton<AuthService>(() => AuthService());
  // Register Sharedpref
  sl.registerLazySingleton<SharedPreferencesManager>(
    () => SharedPreferencesManager(),
  );

  // Register NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(connectivity: sl<Connectivity>()),
  );
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<AppDataProvider>(() => AppDataProvider());
  // registerCategory();
  // registerProducts();
  // registerCart();
}
