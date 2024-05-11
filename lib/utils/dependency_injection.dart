import 'package:get_it/get_it.dart';
import 'package:start_journey/utils/locale_secure_storage.dart';

final GetIt getIt = GetIt.instance;

Future<String> configureDi() async {
  getIt.registerSingleton<LocaleSecureStorage>(LocaleSecureStorage()..init());
  return '';
}
