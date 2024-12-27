import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/provider/local/apod_local_provider.dart';
import 'package:nasa/src/data/provider/remote/apod_remote_provider.dart';
import 'package:nasa/src/data/provider/remote/neo_remote_provider.dart';
import 'package:nasa/src/data/repository/apod_repository_impl.dart';
import 'package:nasa/src/data/repository/contracts/apod_local_provider.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';
import 'package:nasa/src/data/repository/neo_repository_impl.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';
import 'package:nasa/src/domain/repository/neo_repository.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_detail.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/get_neo_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/neo_list/controller/neo_list_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // UseCases
  sl.registerLazySingleton(() => GetApodList(sl()));
  sl.registerLazySingleton(() => GetApodDetail(sl()));
  sl.registerLazySingleton(() => SearchApods(sl()));
  sl.registerLazySingleton(() => ClearCache(sl()));
  sl.registerLazySingleton(() => GetNeoList(sl()));

  // Repository
  sl.registerLazySingleton<ApodRepository>(
    () => ApodRepositoryImpl(
      remoteProvider: sl(),
      localProvider: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<NeoRepository>(
    () => NeoRepositoryImpl(
      remoteProvider: sl(),
    ),
  );

  // Providers
  sl.registerLazySingleton<ApodRemoteProvider>(
    () => ApodRemoteProviderImpl(dio: sl()),
  );
  sl.registerLazySingleton<ApodLocalProvider>(
    () => ApodLocalProviderImpl(apodBox: sl()),
  );
  sl.registerLazySingleton(
    () => NeoRemoteProvider(dio: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // Controllers
  sl.registerFactory(
    () => ApodListController(
      getApodList: sl(),
      searchApods: sl(),
      clearCache: sl(),
    ),
  );
  sl.registerFactory(
    () => NeoListController(
      getNeoList: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final apodBox = await Hive.openBox<ApodHiveModel>('apods');
  sl.registerLazySingleton(() => apodBox);
}
