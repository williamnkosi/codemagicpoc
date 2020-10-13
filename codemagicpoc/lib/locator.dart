import 'package:codemagicpoc/app_config.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => AppEnvConfig());
}
