import 'dart:async';

import 'package:flutter/material.dart';

import 'next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minute = 0;
  int _second = 0;
  int _micro = 0;

  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_minute'.padLeft(2, "0"),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '$_second'.padLeft(2, "0"),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '.',
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '$_micro'.padLeft(2, "0"),
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  toggleTimer();
                },
                child: Text(
                    _isRunning ? 'ストップ' : 'スタート',
                  style: TextStyle(
                    color: _isRunning ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                resetTimer();
              },
                child: Text(
                    'リセット',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  void toggleTimer() {
    if(_isRunning) {
      _timer?.cancel();
    } else {

      _timer = Timer.periodic(
        const Duration(milliseconds: 10),
            (timer) {
          setState(() {
            _micro++;
          });

          if(_micro == 100) {
            _micro = 0;
            _second++;
          }
          if(_second == 60) {
            _second = 0;
            _minute++;
          }
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();

    setState(() {
      _minute = 0;
      _second = 0;
      _micro = 0;
      _isRunning = false;
    });
  }
}
