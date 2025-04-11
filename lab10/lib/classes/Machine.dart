import 'ICoffee.dart';

class Machine {
  static final Machine _instance = Machine._internal();
  factory Machine() => _instance;

  int _coffeeBeans = 500;
  int _milk = 1000;
  int _water = 2000;
  int _cash = 0;

  Machine._internal();

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  bool isAvailable(ICoffee coffee) {
    return _coffeeBeans >= coffee.beansNeeded &&
        _milk >= coffee.milkNeeded &&
        _water >= coffee.waterNeeded;
  }

  bool makeCoffee(ICoffee coffee) {
    if (!isAvailable(coffee)) return false;
    _coffeeBeans -= coffee.beansNeeded;
    _milk -= coffee.milkNeeded;
    _water -= coffee.waterNeeded;
    _cash += coffee.price;
    return true;
  }

  void addCoffeeBeans(int amount) => _coffeeBeans += amount;
  void addMilk(int amount) => _milk += amount;
  void addWater(int amount) => _water += amount;
  void collectCash() => _cash = 0;
}
