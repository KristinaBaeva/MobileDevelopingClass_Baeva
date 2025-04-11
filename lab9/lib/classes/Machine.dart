class Machine {

  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Machine({required int coffeeBeans, required int milk, required int water, int cash = 0})
      : _coffeeBeans = coffeeBeans,
        _milk = milk,
        _water = water,
        _cash = cash;

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  bool isAvailable({required int beansNeeded, required int waterNeeded, int milkNeeded = 0}) {
    return _coffeeBeans >= beansNeeded && _water >= waterNeeded && _milk >= milkNeeded;
  }

  void _subtractResources({required int beans, required int water, int milk = 0}) {
    _coffeeBeans -= beans;
    _water -= water;
    _milk -= milk;
  }

  bool makeCoffee({required int price}) {
    const beansNeeded = 50;
    const waterNeeded = 100;

    if (!isAvailable(beansNeeded: beansNeeded, waterNeeded: waterNeeded)) {
      return false;
    }

    _subtractResources(beans: beansNeeded, water: waterNeeded);
    _cash += price;
    return true;
  }

  void addCoffeeBeans(int amount) => _coffeeBeans += amount;
  void addMilk(int amount) => _milk += amount;
  void addWater(int amount) => _water += amount;
  void collectCash() => _cash = 0;
}