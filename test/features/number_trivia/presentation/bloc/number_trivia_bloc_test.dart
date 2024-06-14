import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:num_sentence/core/util/input_converter.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:num_sentence/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  InputConverter
])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getTriviaForConcreteNumber: mockGetConcreteNumberTrivia,
      getTriviaForRandomNumber: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,);
  });

  test('initialState should be Empty', () async{
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test('should call the InputConverter to validate '
        'and convert the string to an unsigned integer', () async{
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Right(tNumberParsed));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async*{
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later
      final expected = [
        Empty(),
        const Error(message: invalidInputFailureMessage)
      ];

      expectLater(bloc.state, emitsInOrder(expected));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));

    });


  });
}