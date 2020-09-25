import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_starter_template/layers/domain/repositories/i_todo_repository.dart';
import 'package:flutter_starter_template/layers/domain/stores/i_counter_page_store.dart';
import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/layers/presentation/design_system/design_system.dart';
import 'package:flutter_starter_template/generated/l10n.dart';

class CounterPage extends StatelessWidget {
  final ICounterPageStore store = getIt();
  final ITodoRepository client = getIt();

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
                  style: DesignSystem.of(context).text.h4,
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
