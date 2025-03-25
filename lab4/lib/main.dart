import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherCard {
  final String temperature;
  final String city;
  final String country;
  final String weatherType;
  final String assetPath;

  WeatherCard({
    required this.temperature,
    required this.city,
    required this.country,
    required this.weatherType,
    required this.assetPath,
  });
}

class WeatherApp extends StatelessWidget {
  final List<WeatherCard> cards = [
    WeatherCard(
      temperature: '19',
      city: 'Montreal',
      country: 'Canada',
      weatherType: 'Mid Rain',
      assetPath: 'assets/images/Moon.png',
    ),
    WeatherCard(
      temperature: '20',
      city: 'Toronto',
      country: 'Canada',
      weatherType: 'Fast Wind',
      assetPath: 'assets/images/Wind.png',
    ),
    WeatherCard(
      temperature: '15',
      city: 'Ottawa',
      country: 'Canada',
      weatherType: 'Mid Rain',
      assetPath: 'assets/images/Sun.png',
    ),

    WeatherCard(
      temperature: '10',
      city: 'Calgary',
      country: 'Canada',
      weatherType: 'Cloudy',
      assetPath: 'assets/images/Cloudy.png',
    ),

     WeatherCard(
      temperature: '11',
      city: 'Edmonton',
      country: 'Canada',
      weatherType: 'Sunny',
      assetPath: 'assets/images/SunCloud.png',
    ),         
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHomePage(cards: cards),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  final List<WeatherCard> cards;

  const WeatherHomePage({required this.cards, Key? key}) : super(key: key);

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  bool isCelsius = true;

  void _changeTemperatureUnit() {
    setState(() {
      isCelsius = !isCelsius;
    });
  }

  double _convertToFahrenheit(String celsius) {
    final temp = double.parse(celsius);
    return (temp * 9 / 5) + 32;
  }

  IconData _getWeatherIcon(String type) {
    switch (type.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.cloud;
      case 'mid rain':
        return Icons.beach_access;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2D3258),
              Color(0xFF242645),
              Color(0xFF612FAB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isCelsius ? Icons.thermostat : Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                    onPressed: _changeTemperatureUnit,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cards.length,
                itemBuilder: (context, index) {
                  return _buildWeatherCard(widget.cards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherCard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5936B4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(500),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isCelsius
                    ? '${card.temperature}°C'
                    : '${_convertToFahrenheit(card.temperature).toStringAsFixed(1)}°F',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                card.city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                card.country,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Image.asset(
                card.assetPath,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    _getWeatherIcon(card.weatherType),
                    size: 60,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                card.weatherType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  }