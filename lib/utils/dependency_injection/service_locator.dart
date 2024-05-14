import 'package:chat/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
Future<void> registerServices() async {
  sl.registerSingleton<AuthService>(AuthService());
}
