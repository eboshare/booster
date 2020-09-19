import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_starter_template/generated/l10n.dart';
import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/networking/clients/json_placeholder.dart';
import 'package:flutter_starter_template/presentation/domain/counter_store.dart';
import 'package:flutter_starter_template/presentation/theme/theme.dart';

class CounterPage extends StatelessWidget {
  final CounterPageStore store = getIt();
  final JsonPlaceholderClient client = getIt();

  @override
  Widget build(BuildContext context) {
    final str = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(str.counterPageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              str.counterBody,
              textAlign: TextAlign.center,
            ),
            Observer(
              builder: (_) {
                return Text(
                  store.count.toString(),
                  style: Thm.of(context).textTheme.h4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: store.increment,
        tooltip: str.incrementButtonTooltip,
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
