import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:num_sentence/core/error/failure.dart';
import 'package:num_sentence/core/usecases/usecase.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;
  GetRandomNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async{
    return await numberTriviaRepository.getRandomNumberTrivia();
  }

}
