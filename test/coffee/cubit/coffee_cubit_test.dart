import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/coffee/cubit/coffee_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeCubit', () {
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = _MockCoffeeRepository();
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(CoffeeCubit(coffeeRepository), isNotNull);
      });
      test('initial state is correct', () {
        expect(
          CoffeeCubit(coffeeRepository).state,
          const CoffeeState(status: CoffeeRequestStatus.initial),
        );
      });
    });

    group('getCoffee', () {
      late CoffeePicture coffeePicture;

      setUp(() {
        coffeePicture = CoffeePicture(Uint8List.fromList([1, 2, 3]));
      });
      blocTest<CoffeeCubit, CoffeeState>(
        'coffeeRepository.getCoffeePicture is called once',
        setUp: () {
          when(
            () => coffeeRepository.getCoffeePicture(),
          ).thenAnswer((_) async => coffeePicture);
        },
        build: () => CoffeeCubit(coffeeRepository),
        act: (cubit) => cubit.getCoffee(),
        verify: (_) => verify(
          () => coffeeRepository.getCoffeePicture(),
        ).called(1),
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'emits [loading, failed] when coffeeRepository.getCoffeePicture throws',
        setUp: () {
          when(() => coffeeRepository.getCoffeePicture()).thenThrow(
            Exception('oops'),
          );
        },
        build: () => CoffeeCubit(coffeeRepository),
        act: (cubit) => cubit.getCoffee(),
        expect: () => <CoffeeState>[
          const CoffeeState(status: CoffeeRequestStatus.loading),
          const CoffeeState(status: CoffeeRequestStatus.failed),
        ],
      );

      blocTest<CoffeeCubit, CoffeeState>(
        '''
        emits [loading, success with CoffeePicture] when
        coffeeRepository.getCoffeePicture returns CoffeePicture''',
        setUp: () {
          when(
            () => coffeeRepository.getCoffeePicture(),
          ).thenAnswer((_) async => coffeePicture);
        },
        build: () => CoffeeCubit(coffeeRepository),
        act: (cubit) => cubit.getCoffee(),
        expect: () => <CoffeeState>[
          const CoffeeState(status: CoffeeRequestStatus.loading),
          CoffeeState(
            status: CoffeeRequestStatus.successful,
            coffeePicture: coffeePicture,
          ),
        ],
      );
    });

    group('reset', () {
      blocTest<CoffeeCubit, CoffeeState>(
        'emits initial state',
        build: () => CoffeeCubit(coffeeRepository),
        seed: () => const CoffeeState(status: CoffeeRequestStatus.failed),
        act: (cubit) => cubit.reset(),
        expect: () => <CoffeeState>[
          const CoffeeState(status: CoffeeRequestStatus.initial),
        ],
      );
    });
  });
}
