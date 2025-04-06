import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Первый экран'),
        backgroundColor: Color.fromARGB(255, 116, 76, 175),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 116, 76, 175),
          ),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Вы выбрали: $result'),
                  backgroundColor: Color.fromARGB(255, 116, 76, 175),
                ),
              );
            }
          },
          child: const Text(
            'Перейти на второй экран',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Второй экран'),
        backgroundColor: Color.fromARGB(255, 116, 76, 175),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 116, 76, 175),
              ),
              onPressed: () => Navigator.pop(context, 'Да'),
              child: const Text('Да', style: TextStyle(color: Colors.white))),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 116, 76, 175),
              ),
              onPressed: () => Navigator.pop(context, 'Нет'),
              child: const Text('Нет', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}