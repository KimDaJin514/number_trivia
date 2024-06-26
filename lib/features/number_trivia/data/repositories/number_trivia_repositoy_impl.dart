import 'package:dartz/dartz.dart';
import 'package:num_sentence/core/error/exception.dart';
import 'package:num_sentence/core/error/failure.dart';
import 'package:num_sentence/core/network/network_info.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async{
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
    // if(await networkInfo.isConnected) {
    //   try {
    //     final remoteTrivia = await remoteDataSource.getConcreteNumberTrivia(number);
    //
    //     localDataSource.cacheNumberTrivia(remoteTrivia);
    //     return Right(remoteTrivia);
    //
    //   }on ServerException{
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try{
    //     final localTrivia = await localDataSource.getLastNumberTrivia();
    //     return Right(localTrivia);
    //
    //   }on CacheException {
    //     return Left(CacheFailure());
    //   }
    //
    // }

  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
    return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
    // if(await networkInfo.isConnected) {
    //   try {
    //     final remoteTrivia = await remoteDataSource.getRandomNumberTrivia();
    //
    //     localDataSource.cacheNumberTrivia(remoteTrivia);
    //     return Right(remoteTrivia);
    //
    //   }on ServerException{
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try{
    //     final localTrivia = await localDataSource.getLastNumberTrivia();
    //     return Right(localTrivia);
    //
    //   }on CacheException {
    //     return Left(CacheFailure());
    //   }
    //
    // }
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom
  ) async{

    if(await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);

        return Right(remoteTrivia);

      }on ServerException{
        return Left(ServerFailure());
      }

    } else {
      try{
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);

      }on CacheException {
        return Left(CacheFailure());
      }

    }
  }
}
