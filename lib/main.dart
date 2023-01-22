import 'package:coffee/app/app.dart';
import 'package:coffee/bootstrap.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:coffee_storage_repository/coffee_storage_repository.dart';

void main() {
  bootstrap((coffeeLocalStorageApi) {
    final coffeeRepository = CoffeeRepository();
    final coffeeStorageRepository = CoffeeStorageRepository(
      coffeeLocalStorageApi,
    );
    return App(
      coffeeRepository: coffeeRepository,
      coffeeStorageRepository: coffeeStorageRepository,
    );
  });
}
