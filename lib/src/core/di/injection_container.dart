import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/provider/local/apod_local_provider.dart';
import 'package:nasa/src/data/provider/remote/apod_remote_provider.dart';
import 'package:nasa/src/data/repository/apod_repository_impl.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';
import 'package:nasa/src/domain/use_case/get_apod_detail.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // UseCases
  sl.registerLazySingleton(() => GetApodList(sl()));
  sl.registerLazySingleton(() => GetApodDetail(sl()));
  sl.registerLazySingleton(() => SearchApods(sl()));

  // Repository
  sl.registerLazySingleton<ApodRepository>(
        () => ApodRepositoryImpl(
      remoteProvider: sl(),
      localProvider: sl(),
      networkInfo: sl(),
    ),
  );

  // Providers
  sl.registerLazySingleton<ApodRemoteProvider>(
        () => ApodRemoteProviderImpl(dio: sl()),
  );
  sl.registerLazySingleton<ApodLocalProvider>(
        () => ApodLocalProviderImpl(apodBox: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  final apodBox = await Hive.openBox<ApodHiveModel>('apods');
  sl.registerLazySingleton(() => apodBox);
}