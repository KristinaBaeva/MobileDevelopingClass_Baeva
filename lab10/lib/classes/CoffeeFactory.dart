import 'ICoffee.dart';
import 'Espresso.dart';
// import 'Latte.dart';
// import 'Cappuccino.dart';

class CoffeeFactory {
  static ICoffee createCoffee(String type) {
    switch (type) {
      case '1':
        return Espresso();
      // case '2':
      //   return Latte();
      // case '3':
      //   return Cappuccino();
      default:
        throw Exception('Неизвестный тип кофе');
    }
  }
}
