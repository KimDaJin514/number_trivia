import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:num_sentence/core/network/network_info.dart';
import 'package:num_sentence/core/util/input_converter.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/repositories/number_trivia_repositoy_impl.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:num_sentence/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';

final sl = GetIt.instance;

Future<void> init() async{
  // Features

  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        inputConverter: sl(),
      ));

  // Use case
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));
  
  // Data Source
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
          () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
          () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() async => await SharedPreferences.getInstance());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
