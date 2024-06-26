import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main(){
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);
  
  test('should get trivia for the number from the repository', () async{
    // arrange
    when(
        mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => const Right(tNumberTrivia));
    
    // act
    final result = await usecase(const Params(number: tNumber));
    
    // assert
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
  });
}