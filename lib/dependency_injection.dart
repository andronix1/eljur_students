import 'package:eljur_students/core/dynamic_db/dynamic_db.dart';
import 'package:eljur_students/core/dynamic_db/dynamic_db_notifier.dart';
import 'package:eljur_students/core/dynamic_db/loading_db.dart';
import 'package:eljur_students/core/eljur_uri_former.dart';
import 'package:eljur_students/features/eljur_auth/data/datasources/accounts_local_data_source.dart';
import 'package:eljur_students/features/eljur_auth/data/datasources/accounts_remote_data_source.dart';
import 'package:eljur_students/features/eljur_auth/data/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';
import 'package:eljur_students/features/eljur_auth/domain/usecases/login_usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/usecases/logout_usecase.dart';
import 'package:eljur_students/features/eljur_auth/presentation/bloc/auth_bloc.dart';
import 'package:eljur_students/features/schedule/data/datasources/schedule_local_datasource.dart';
import 'package:eljur_students/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:eljur_students/features/schedule/data/repositories/schedule_repository.dart';
import 'package:eljur_students/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:eljur_students/features/schedule/domain/usecases/get_schedule_for_date_usecase.dart';
import 'package:eljur_students/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:eljur_students/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;
String _saveDir = '';

Future<void> init() async {
  _saveDir = (await getApplicationDocumentsDirectory()).path;

  // Core
  locator.registerLazySingleton<EljurUriFormer>(() => EljurUriFormerImpl());
  locator
      .registerLazySingleton(() => DynamicDbNotifier(mainFolderName: _saveDir));

  await _initAuth();
  await _initSchedule();

  // Postprocessing
  await locator<AccountsRepository>().fetchCurrentAccount();
}

Future<void> _initAuth() async {
  // BLoCs
  locator.registerFactory(() => AuthBloc(loginUseCase: locator()));

  // Data sources
  locator.registerLazySingleton(
      () => LoadingDb(dbFilename: join(_saveDir, 'accounts.db')),
      instanceName: "accountsDb");
  locator.registerLazySingleton<AccountsLocalDataSource>(() =>
      AccountsLocalDataSourceImpl(
          database: locator(instanceName: "accountsDb")));
  locator.registerLazySingleton<AccountsRemoteDataSource>(
      () => AccountsRemoteDataSourceImpl(eljurUriFormer: locator()));

  // Repositories
  locator.registerLazySingleton<AccountsRepository>(() =>
      AccountsRepositoryImpl(
          localDataSource: locator(),
          remoteDataSource: locator(),
          notifier: locator()));

  // Use cases
  locator
      .registerLazySingleton(() => LoginUseCase(accountsRepository: locator()));
  locator.registerLazySingleton(
      () => LogoutUseCase(accountsRepository: locator()));
}

Future<void> _initSchedule() async {
  // BLoCs
  locator.registerFactory(() => ScheduleBloc(getSchedule: locator()));

  // Data sources
  locator.registerLazySingleton(
      () => DynamicDb(notifier: locator(), dbFilename: 'schedule.db'));
  locator.registerLazySingleton<ScheduleLocalDataSource>(
      () => ScheduleLocalDataSourceImpl(dynamicDb: locator()));
  locator.registerLazySingleton<ScheduleRemoteDataSource>(
      () => ScheduleRemoteDataSourceImpl(eljurUriFormer: locator()));

  // Repositories
  locator.registerLazySingleton<ScheduleRepository>(() =>
      ScheduleRepositoryImpl(
          localDataSource: locator(), remoteDataSource: locator()));

  // Use cases
  locator
      .registerLazySingleton(() => GetScheduleUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => GetScheduleForDateUseCase(repository: locator()));
}
