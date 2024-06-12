part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  @override
  List<Object?> get props => [];

  const NumberTriviaState();
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;
  const Loaded({required this.trivia});

  @override
  List<Object?> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;
  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}