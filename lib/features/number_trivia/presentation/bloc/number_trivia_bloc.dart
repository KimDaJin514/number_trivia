import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:num_sentence/core/util/input_converter.dart';
import 'package:num_sentence/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getTriviaForConcreteNumber;
  final GetRandomNumberTrivia getTriviaForRandomNumber;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getTriviaForConcreteNumber,
    required this.getTriviaForRandomNumber,
    required this.inputConverter,
  }) : super(Empty()) {

    on<GetTriviaForConcreteNumber>((event, emit) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      inputEither.fold(
        (l) async* {
          yield const Error(message: invalidInputFailureMessage);
          // emit(const Error(message: invalidInputFailureMessage));
        },
        (r) {
        },
      );
    });
  }
}
