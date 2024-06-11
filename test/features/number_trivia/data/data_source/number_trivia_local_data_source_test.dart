import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:num_sentence/core/error/exception.dart';
import 'package:num_sentence/features/number_trivia/data/data_source/number_trivia_local_data_source.dart';
import 'package:num_sentence/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main(){
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  
  group('getLastNumberTrivia', () { 
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test('should return NumberTrivia from SharedPreferences when there is one in the cache', () async{
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));

      // act
      final result = await dataSource.getLastNumberTrivia();

      // assert
      verify(mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cached value', () async{
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      // final result = await dataSource.getLastNumberTrivia();

      // assert
      // expect(result, throwsA(const TypeMatcher<CacheException>()));

      // act
      final call = dataSource.getLastNumberTrivia;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 1);
    final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

    test('should call SharedPreferences to cache the data', () async {
      // when
      when(mockSharedPreferences.setString(cachedNumberTrivia, expectedJsonString))
          .thenAnswer((_) async => true);

      // act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // assert
      verify(mockSharedPreferences.setString(cachedNumberTrivia, expectedJsonString));
    });
  });
}
