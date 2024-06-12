import 'package:dartz/dartz.dart';
import 'package:num_sentence/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try{
      final integer = int.parse(str);

      if(integer < 0) {
        throw const FormatException();
      }else {
        return Right(integer);
      }

    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure{}