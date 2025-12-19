import 'package:flutter/material.dart';

const int counterRangeMax = 4;
const int counterRangeMinOver5 = 5;
const String messageUnder5 = '頑張って！';
const String messageOver5 = 'すごい！';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CounterPage());
  }
}

class CounterViewModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  String getMessage() {
    if (_count >= 1 && _count <= counterRangeMax) {
      return messageUnder5;
    } else if (_count >= counterRangeMinOver5) {
      return messageOver5;
    }
    return '';
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _counter = CounterViewModel();

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _counter,
      builder: (context, _) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${_counter.count}', style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                Text(
                  _counter.getMessage(),
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _counter.increment,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
