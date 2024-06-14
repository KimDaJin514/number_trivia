import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:num_sentence/core/error/exception.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_remote_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../Fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main(){
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockClientFailure404(){
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should perform a GET request on a URL with number being the endpoint '
        'and with application/json head', () async{
      // arrange
      setUpMockClientSuccess200();

      // act
      dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      verify(mockClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {'Content-Type': 'application/json'}
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)', () async{
      // arrange
      setUpMockClientSuccess200();

      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is 404 or other', () async{
      // arrange
      setUpMockClientFailure404();

      // act
      final call = dataSource.getConcreteNumberTrivia;

      // assert
      expect(() => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should perform a GET request on a URL with number being the endpoint '
        'and with application/json head', () async{
      // arrange
      setUpMockClientSuccess200();

      // act
      await dataSource.getRandomNumberTrivia();

      // assert
      verify(mockClient.get(
          Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'}
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)', () async{
      // arrange
      setUpMockClientSuccess200();

      // act
      final result = await dataSource.getRandomNumberTrivia();

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is 404 or other', () async{
      // arrange
      setUpMockClientFailure404();

      // act
      final call = dataSource.getRandomNumberTrivia;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}