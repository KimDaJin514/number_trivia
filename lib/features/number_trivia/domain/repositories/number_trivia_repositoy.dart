import 'package:dartz/dartz.dart';
import 'package:num_sentence/core/error/failure.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';

abstract interface class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}