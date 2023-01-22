import 'dart:typed_data';
import 'package:coffee_api/coffee_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements http.Client {}

class _MockResponse extends Mock implements http.Response {}

class _FakeUri extends Fake implements Uri {}

void main() {
  group('CoffeeApi', () {
    late http.Client httpClient;

    setUp(() {
      httpClient = _MockHttpClient();
    });

    group('constructor', () {
      test('can be instantiated without injected client', () {
        expect(CoffeeApi(), isNotNull);
      });
      test('can be instantiated with injected client', () {
        expect(CoffeeApi(httpClient: httpClient), isNotNull);
      });
    });

    group('getCoffeeImgBytes', () {
      late http.Response response;
      late CoffeeApi coffeeApi;

      setUpAll(() {
        registerFallbackValue(_FakeUri());
      });

      setUp(() {
        response = _MockResponse();
        coffeeApi = CoffeeApi(httpClient: httpClient);
      });

      test('makes correct http request', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List.fromList([1, 2, 3]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await coffeeApi.getCoffeeImgBytes();
        verify(
          () => httpClient.get(
            Uri.https(
              'coffee.alexflipnote.dev',
              'random',
            ),
          ),
        ).called(1);
      });
      test('throws CoffeeRequestFailure on non-200 http response', () {
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(coffeeApi.getCoffeeImgBytes(), throwsA(isA<CoffeeRequestFailure>()));
      });
      test('returns correct data on valid response', () async {
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List.fromList([1, 2, 3]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await coffeeApi.getCoffeeImgBytes();
        expect(actual, isA<Uint8List>());
      });
    });
  });
}
