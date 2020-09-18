import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/presentation/domain/counter_store.dart';

class CounterPage extends StatelessWidget {
  final CounterPageStore store = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button\nthis many times:',
              textAlign: TextAlign.center,
            ),
            Observer(
              builder: (_) {
                return Text(
                  store.count.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: store.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
