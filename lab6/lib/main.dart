import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 110, 56, 190), 
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 110, 56, 190), 
        ),
      ),
      home: const AreaCalculator(),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({Key? key}) : super(key: key);

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateArea() {
    if (_formKey.currentState!.validate()) {
      final width = double.parse(_widthController.text);
      final height = double.parse(_heightController.text);
      final area = width * height;

      setState(() {
        _result = 'S = $width * $height = ${area.toStringAsFixed(2)}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Площадь успешно вычислена'),
          backgroundColor: Color.fromARGB(255, 116, 76, 175),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор площади'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _widthController,
                decoration: const InputDecoration(
                  labelText: 'Ширина',
                  hintText: 'Введите ширину',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ширину';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Высота',
                  hintText: 'Введите высоту',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите высоту';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
  onPressed: _calculateArea,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 110, 56, 190), // Установите цвет фона кнопки
  ),
  child: const Text('Вычислить'),
),
              const SizedBox(height: 20),
              if (_result.isNotEmpty)
                Text(
                  _result,
                  style: const TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}