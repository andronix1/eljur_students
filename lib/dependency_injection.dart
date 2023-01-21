import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/features/eljur_auth/data/datasources/accounts_local_data_source.dart';
import 'package:eljur_students/features/eljur_auth/data/datasources/accounts_remote_data_source.dart';
import 'package:eljur_students/features/eljur_auth/data/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/domain/usecases/login_usecase.dart';
import 'package:eljur_students/features/eljur_auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

GetIt sl = GetIt.asNewInstance();

Future<void> init() async {
  final saveDir = (await getApplicationDocumentsDirectory()).path;
  await _initAuth(saveDir);
}

Future<void> _initAuth(String saveDir) async {
  // BLoCs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  // Data sources
  final database =
      await databaseFactoryIo.openDatabase(join(saveDir, 'accounts.db'));
  sl.registerLazySingleton<AccountsLocalDataSource>(
      () => AccountsLocalDataSourceImpl(database: database));
  sl.registerLazySingleton<AccountsRemoteDataSource>(
      () => AccountsRemoteDataSourceImpl(eljurUriFormer: sl()));

  // Repositories
  sl.registerLazySingleton<AccountsRepository>(() =>
      AccountsRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(accountsRepository: sl()));

  // Core
  sl.registerLazySingleton<EljurUriFormer>(() => EljurUriFormerImpl());
}
