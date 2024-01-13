import 'package:dio/dio.dart';
import 'package:eljur_students/core/database/user_database.dart';
import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/core/eljur/requesters/dio_requester.dart';
import 'package:eljur_students/core/eljur/uri_middlewares/eljur_base_middleware.dart';
import 'package:eljur_students/core/eljur/uri_middlewares/logger_middleware.dart';
import 'package:eljur_students/features/auth/data/auth_methods/credentials_auth_method.dart';
import 'package:eljur_students/features/auth/data/auth_middleware.dart';
import 'package:eljur_students/features/auth/data/local/sembast_users_database.dart';
import 'package:eljur_students/features/auth/data/remote/users_remote_impl.dart';
import 'package:eljur_students/features/auth/domain/users_database.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/domain/users_remote.dart';
import 'package:eljur_students/features/auth/domain/users_repository.dart';
import 'package:eljur_students/features/auth/presentation/screens/credentials_auth/credentials_auth_cubit.dart';
import 'package:eljur_students/features/auth/presentation/screens/token_auth/token_auth_cubit.dart';
import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_cubit.dart';
import 'package:eljur_students/features/diary/data/local/sembast_diary_databse.dart';
import 'package:eljur_students/features/diary/data/remote/diary_remote.dart';
import 'package:eljur_students/features/diary/domain/dary_remote.dart';
import 'package:eljur_students/features/diary/domain/diary_database.dart';
import 'package:eljur_students/features/diary/domain/diary_repository.dart';
import 'package:eljur_students/features/diary/presentation/screens/diary_view/diary_view_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

var getIt = GetIt.asNewInstance();

Future initUsersDi() async {
  getIt.registerLazySingleton<UsersDatabase>(
      () => SembastUsersDatabase(database: getIt(instanceName: 'authDb')));

  getIt.registerLazySingleton<UsersRemote>(
      () => UsersRemoteImpl(eljurUriFormer: getIt(), requester: getIt()));

  getIt.registerLazySingleton<UsersRepository>(
      () => UsersRepository(database: getIt(), remote: getIt()));

  getIt.registerLazySingleton<AuthProvider>(
      () => AuthProvider(repository: getIt()));

  getIt.registerLazySingleton<AuthMiddleware>(
      () => AuthMiddleware(provider: getIt()));

  getIt.registerFactory(() => TokenAuthCubit(authProvider: getIt()));

  getIt.registerLazySingleton<CredentialsAuthMethodFactory>(() =>
      CredentialsAuthMethodFactory(
          requester: getIt(), eljurUriFormer: getIt()));

  getIt.registerFactory(() => CredentialsAuthCubit(
      authProvider: getIt(), credentialsAuthMethodFactory: getIt()));

  getIt.registerFactory(() => SelectUserCubit(provider: getIt()));

  getIt<Requester>().middlewares.insert(0, getIt<AuthMiddleware>());
  await getIt<AuthProvider>().initDefaultUser();
}

void initDiaryDi() {
  getIt.registerLazySingleton<DiaryRemote>(
      () => DiaryRemoteImpl(requester: getIt(), uriFormer: getIt()));
  getIt.registerLazySingleton<DiaryDatabase>(
      () => SembastDiaryDatabase(database: getIt()));
  getIt.registerLazySingleton<DiaryRepository>(
      () => DiaryRepository(database: getIt(), remote: getIt()));

  getIt.registerLazySingleton<DiaryViewCubit>(
      () => DiaryViewCubit(repository: getIt()));
}

Future initDi() async {
  var applicationDocumentsPath = await getApplicationDocumentsDirectory();
  getIt.registerSingleton<Database>(
      await databaseFactoryIo
          .openDatabase(join(applicationDocumentsPath.path, 'auth.db')),
      instanceName: 'authDb');
  getIt.registerLazySingleton<CurrentUserDatabase>(() => CurrentUserDatabase(
      authProvider: getIt(), dbDirectory: applicationDocumentsPath));
  getIt.registerSingleton<EljurUriFormer>(EljurUriFormerImpl());
  getIt.registerLazySingleton<Requester>(() => DioRequester(dio: Dio())
    ..middlewares.addAll([
      EljurBaseMiddleware(),
      LoggerMiddleware(logResponses: true, logUris: true)
    ]));

  await initUsersDi();
  initDiaryDi();
}
