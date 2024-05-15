import 'package:chat/services/auth_service.dart';
import 'package:chat/services/db_service.dart';
import 'package:chat/services/media_service.dart';
import 'package:chat/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
Future<void> registerServices() async {
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerSingleton<MediaService>(MediaService());
  sl.registerSingleton<StorageService>(StorageService());
  sl.registerSingleton<DatabaseService>(DatabaseService());
}
