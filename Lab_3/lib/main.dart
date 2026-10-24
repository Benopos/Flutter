import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  bool _isAgreed = false;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шолохов Роман Юрьевич'), 
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Калькулятор ИМТ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Вес (кг)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите вес';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Рост (см)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите рост';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CheckboxListTile(
                title: const Text('Я согласен на обработку данных'),
                value: _isAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    _isAgreed = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              
              if (!_isAgreed)
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    'Необходимо согласие на обработку данных',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _isAgreed) {
                    
                    double weight = double.parse(_weightController.text);
                    double height = double.parse(_heightController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          weight: weight,
                          height: height,
                        ),
                      ),
                    );
                  } else if (!_isAgreed) {
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Поставьте галочку согласия!')),
                    );
                  }
                },
                child: const Text('Рассчитать ИМТ', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  final double weight;
  final double height;

  const SecondScreen({super.key, required this.weight, required this.height});

  @override
  Widget build(BuildContext context) {
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);
    
    String verdict;
    Color verdictColor;

    if (bmi < 18.5) {
      verdict = 'Недостаточная масса тела';
      verdictColor = Colors.orange;
    } else if (bmi >= 18.5 && bmi < 25) {
      verdict = 'Норма';
      verdictColor = Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      verdict = 'Избыточная масса тела';
      verdictColor = Colors.orange;
    } else {
      verdict = 'Ожирение';
      verdictColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ваш индекс массы тела:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                bmi.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: verdictColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                verdict,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: verdictColor,
                ),
              ),
              const SizedBox(height: 40),
              
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Вернуться назад'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}