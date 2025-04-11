import 'package:flutter/material.dart';

void main() => runApp(CoffeeApp());

class CoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: CoffeeHomePage(),
    );
  }
}

class CoffeeHomePage extends StatefulWidget {
  @override
  _CoffeeHomePageState createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  final Machine coffeeMachine = Machine();

  void _makeCoffee() {
    final coffee = Espresso();
    final success = coffeeMachine.makeCoffee(coffee);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(success ? 'Готово' : 'Ошибка'),
        content: Text(success ? 'Ваш ${coffee.name} готов!' : 'Недостаточно ресурсов!'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
    setState(() {});
  }

  void _showRefillDialog(String resourceName, Function(int) onAdd) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Пополнить $resourceName'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Введите количество'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text) ?? 0;
              if (value > 0) onAdd(value);
              setState(() {});
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _collectCash() {
    final collected = coffeeMachine.cash;
    coffeeMachine.collectCash();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Инкассация'),
        content: Text('Вы забрали $collected руб.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Кофемашина')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Ресурсы:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text('Кофейные зерна: ${coffeeMachine.coffeeBeans} гр'),
                    Text('Молоко: ${coffeeMachine.milk} мл'),
                    Text('Вода: ${coffeeMachine.water} мл'),
                    Text('Деньги в машине: ${coffeeMachine.cash} руб'),
                    SizedBox(height: 32),
                    ElevatedButton(onPressed: _makeCoffee, child: Text('Приготовить Эспрессо (50 руб)')),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _showRefillDialog('кофейные зерна', coffeeMachine.addCoffeeBeans),
                      child: Text('Пополнить зерна'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _showRefillDialog('молоко', coffeeMachine.addMilk),
                      child: Text('Пополнить молоко'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _showRefillDialog('воду', coffeeMachine.addWater),
                      child: Text('Пополнить воду'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(onPressed: _collectCash, child: Text('Забрать деньги')),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Machine {
  static final Machine _instance = Machine._internal();
  factory Machine() => _instance;
  Machine._internal();

  int _coffeeBeans = 500;
  int _milk = 1000;
  int _water = 2000;
  int _cash = 0;

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  bool isAvailable(ICoffee coffee) =>
      _coffeeBeans >= coffee.beansNeeded &&
      _milk >= coffee.milkNeeded &&
      _water >= coffee.waterNeeded;

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

abstract class ICoffee {
  int get beansNeeded;
  int get waterNeeded;
  int get milkNeeded;
  int get price;
  String get name;
}

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