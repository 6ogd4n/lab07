import 'package:flutter/material.dart';

void main() {
  runApp(const RgbColorPickerApp());
}

class RgbColorPickerApp extends StatelessWidget {
  const RgbColorPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGB Color Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RgbColorPickerPage(),
    );
  }
}

/// Головна сторінка додатку, яка керує станом кольору (StatefulWidget)
class RgbColorPickerPage extends StatefulWidget {
  const RgbColorPickerPage({super.key});

  @override
  State<RgbColorPickerPage> createState() => _RgbColorPickerPageState();
}

class _RgbColorPickerPageState extends State<RgbColorPickerPage> {
  // Початкові значення RGB
  double _red = 128;
  double _green = 128;
  double _blue = 128;

  @override
  Widget build(BuildContext context) {
    final currentColor = Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );

    // Форматування HEX-коду
    final hexCode = '#${_red.toInt().toRadixString(16).padLeft(2, '0')}'
        '${_green.toInt().toRadixString(16).padLeft(2, '0')}'
        '${_blue.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Варіант 3: Підбір кольорів RGB'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Візуалізація кольору за допомогою Stateless/Stateful віджетів
            ColorDisplayCard(color: currentColor, hexCode: hexCode),
            const SizedBox(height: 24),

            // Панель налаштування каналів
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ColorSliderControl(
                      label: 'Червоний (Red)',
                      value: _red,
                      color: Colors.red,
                      onChanged: (val) => setState(() => _red = val),
                    ),
                    const Divider(),
                    ColorSliderControl(
                      label: 'Зелений (Green)',
                      value: _green,
                      color: Colors.green,
                      onChanged: (val) => setState(() => _green = val),
                    ),
                    const Divider(),
                    ColorSliderControl(
                      label: 'Синій (Blue)',
                      value: _blue,
                      color: Colors.blue,
                      onChanged: (val) => setState(() => _blue = val),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stateless віджет для відображення зразка кольору та текстової інформації
class ColorDisplayCard extends StatelessWidget {
  final Color color;
  final String hexCode;

  const ColorDisplayCard({
    super.key,
    required this.color,
    required this.hexCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          hexCode,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'RGB: (${color.red}, ${color.green}, ${color.blue})',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

/// Stateless віджет для керування одним каналом кольору (повзунок + значення)
class ColorSliderControl extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const ColorSliderControl({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 255,
          divisions: 255,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
          onChanged: onChanged,
        ),
      ],
    );
  }
}