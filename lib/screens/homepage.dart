import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytshare/constants/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
        title: Text(
          Global.appName,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              //Navigator.pushNamed(context, ChatBot.routeName);
            },
            child: Icon(MdiIcons.cogOutline),
          ),
          const Padding(padding: EdgeInsets.all(8))
        ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
