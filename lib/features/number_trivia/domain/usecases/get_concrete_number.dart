import 'package:num_sentence/core/error/failure.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;
  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async{
    return await repository.getConcreteNumberTrivia(number);
  }
}