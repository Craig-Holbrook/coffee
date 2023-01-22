import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';

///repository that uses functions exposed by coffee_api package
class CoffeeRepository {
  ///CoffeeRepository constructor
  CoffeeRepository({CoffeeApi? coffeeApi}) : _coffeeApi = coffeeApi ?? CoffeeApi();

  final CoffeeApi _coffeeApi;

  ///calls coffeeApi.getCoffeeImgBytes to get byte data and returns CoffeePicture
  Future<CoffeePicture> getCoffeePicture() async {
    final coffeeBytes = await _coffeeApi.getCoffeeImgBytes();

    return CoffeePicture(coffeeBytes);
  }
}
