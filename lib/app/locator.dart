
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sauftrag/app/locator.iconfig.dart';

final locator = GetIt.instance;
@injectableInit
Future<void> configure() => $initGetIt(locator);