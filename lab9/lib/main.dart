import 'classes/Machine.dart';

void main() {
  final coffeeMachine = Machine(
    coffeeBeans: 500,
    milk: 1000,
    water: 2000,
  );

  // Simulated user input for testing
  List<String> inputs = ['1', '2', '3', '1', '4', '5'];
  int inputIndex = 0;

  while (true) {
    print('\n=== Кофемашина ===');
    print('1. Приготовить эспрессо (50 руб)');
    print('2. Проверить уровень ресурсов');
    print('3. Пополнить ресурсы');
    print('4. Забрать деньги');
    print('5. Выход');
    print('Выберите действие: ');

    // Simulated input
    final input = inputs[inputIndex++];
    print(input); // Print the simulated input

    switch (input) {
      case '1':
        if (coffeeMachine.makeCoffee(price: 50)) {
          print('Ваш эспрессо готов!');
        } else {
          print('Недостаточно ресурсов для приготовления кофе');
        }
        break;

      case '2':
        print('\nТекущий уровень ресурсов:');
        print('Кофейные зерна: ${coffeeMachine.coffeeBeans} гр');
        print('Молоко: ${coffeeMachine.milk} мл');
        print('Вода: ${coffeeMachine.water} мл');
        print('Деньги в машине: ${coffeeMachine.cash} руб');
        break;

      case '3':
        print('\nЧто вы хотите пополнить?');
        print('1. Кофейные зерна');
        print('2. Молоко');
        print('3. Вода');
        print('Выберите ресурс: ');

        final resource = '1';
        print(resource);
        print('Введите количество: ');
        final amount = 100;
        print(amount);

        if (amount <= 0) {
          print('Некорректное количество');
          break;
        }

        switch (resource) {
          case '1':
            coffeeMachine.addCoffeeBeans(amount);
            print('Добавлено $amount гр кофейных зерен');
            break;
          case '2':
            coffeeMachine.addMilk(amount);
            print('Добавлено $amount мл молока');
            break;
          case '3':
            coffeeMachine.addWater(amount);
            print('Добавлено $amount мл воды');
            break;
          default:
            print('Некорректный выбор');
        }
        break;

      case '4':
        final collected = coffeeMachine.cash;
        coffeeMachine.collectCash();
        print('Вы забрали $collected руб');
        break;

      case '5':
        return;

      default:
        print('Некорректный ввод');
    }

    if (inputIndex >= inputs.length) break;
  }
}