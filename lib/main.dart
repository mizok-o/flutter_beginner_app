import 'package:flutter/material.dart';
import 'todo_page.dart';

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
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [CounterPage(), TodoPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'カウンター'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Todo'),
        ],
      ),
    );
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
    return Scaffold(
      appBar: AppBar(title: const Text('カウンター')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('現在のカウント値:'),
            ListenableBuilder(
              listenable: _counter,
              builder: (context, _) {
                return Column(
                  children: [
                    Text(
                      '${_counter.count}',
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _counter.getMessage(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counter.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
