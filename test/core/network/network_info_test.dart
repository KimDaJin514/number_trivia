import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:num_sentence/core/network/network_info.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection', () async{
      // arrange
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}