import 'ICoffee.dart';

class Espresso implements ICoffee {
  @override
  int get beansNeeded => 50;

  @override
  int get waterNeeded => 100;

  @override
  int get milkNeeded => 0;

  @override
  int get price => 50;

  @override
  String get name => 'Эспрессо';
}
