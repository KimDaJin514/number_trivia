import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:mockito/annotations.dart';
import 'package:num_sentence/core/network/network_info.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';

@GenerateMocks(
  [
    NumberTriviaRepository,
    NumberTriviaRemoteDataSource,
    NumberTriviaLocalDataSource,
    NetworkInfo,
    DataConnectionChecker
  ]
)
void main(){

}