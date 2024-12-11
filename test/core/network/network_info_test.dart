import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/network/network_info.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockConnectionChecker);
  });

  group('NetworkInfoImpl', () {
    group('isConnected', () {
      test('should forward the call to InternetConnectionChecker.hasConnection', () async {
        final hasConnectionFuture = Future.value(true);
        when(mockConnectionChecker.hasConnection).thenAnswer((_) => hasConnectionFuture);

        final result = networkInfo.isConnected;

        verify(mockConnectionChecker.hasConnection);
        expect(result, hasConnectionFuture);
      });

      test('should return true when there is internet connection', () async {
        when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);

        final result = await networkInfo.isConnected;

        verify(mockConnectionChecker.hasConnection);
        expect(result, true);
      });

      test('should return false when there is no internet connection', () async {
        when(mockConnectionChecker.hasConnection).thenAnswer((_) async => false);

        final result = await networkInfo.isConnected;

        verify(mockConnectionChecker.hasConnection);
        expect(result, false);
      });
    });
  });
}