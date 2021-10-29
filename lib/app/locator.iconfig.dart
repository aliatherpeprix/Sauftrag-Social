
import 'package:get_it/get_it.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';

Future<void> $initGetIt(GetIt g, {String? environment}) async{
  g.registerLazySingleton<NavigationViewModel>(() => NavigationViewModel());
  g.registerLazySingleton<AuthenticationViewModel>(() => AuthenticationViewModel());
  g.registerLazySingleton<MainViewModel>(() => MainViewModel());
  //g.registerLazySingleton<MainViewModel>(() => MainViewModel());
}