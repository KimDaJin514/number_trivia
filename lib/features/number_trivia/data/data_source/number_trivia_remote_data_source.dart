import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:num_sentence/core/error/exception.dart';
import 'package:num_sentence/features/number_trivia/data/models/number_trivia_model.dart';

import 'number_trivia_local_data_source.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number)
    => _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia()
    => _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }else {
      throw ServerException();
    }
  }
}

