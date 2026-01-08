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
  // 1. 更新されない「土台（Scaffold）」は外に置く
  return Scaffold(
    appBar: AppBar(title: const Text('カウンター')), // AppBarも再構築されない
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('現在のカウント値:'), // このテキストは固定なので外でOK

          // 2. 「ここだけ更新したい！」という部分だけを ListenableBuilder で囲む
          ListenableBuilder(
            listenable: _counter,
            builder: (context, _) {
              // _counter.notifyListeners() が呼ばれると、ここから下だけが動く
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
    // 3. ボタンも「中身のアイコン」は変わらないので外に置く
    floatingActionButton: FloatingActionButton(
      onPressed: _counter.increment,
      child: const Icon(Icons.add),
    ),
  );
}
}
