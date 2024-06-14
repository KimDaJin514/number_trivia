import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:mockito/annotations.dart';
import 'package:num_sentence/core/network/network_info.dart';
import 'package:num_sentence/core/util/input_converter.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:num_sentence/features/number_trivia/domain/repositories/number_trivia_repositoy.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:num_sentence/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    NumberTriviaRepository,
    NumberTriviaRemoteDataSource,
    NumberTriviaLocalDataSource,
    NetworkInfo,
    DataConnectionChecker,
    SharedPreferences,
    http.Client,
  ]
)
void main(){

}