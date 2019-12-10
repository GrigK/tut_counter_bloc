import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tut_block/counter/counter_bloc.dart';
import 'package:tut_block/theme_block.dart';
import 'package:tut_block/generated/i18n.dart';


class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// CounterBloc передан сюда из HomePage
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).titleHomePage)),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              S.of(context).textOfHomePage,
            ),
              /// передача экземпляра текущего BloC дочернему виджету
              Center(
                child:  BlocProvider.value(
                    key: UniqueKey(),
                    value: counterBloc,
                    child: CounterText(),
                  )
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 0,
              child: Icon(Icons.add),
              tooltip: S.of(context).tooltipInc,
              onPressed: () {
                counterBloc.add(CounterEvent.increment);
                // Используем глобальный BLoC (тема)
                BlocProvider.of<ThemeBloc>(context).add(ThemeEvent.toggle);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 1,
              child: Icon(Icons.remove),
              tooltip: S.of(context).tooltipDec,
              onPressed: () {
                counterBloc.add(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// пример использования BLoC на уровне виджета
/// BLoC ему передан от родителя
class CounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, count) {
        return Text('$count',
          style: Theme.of(context).textTheme.display1);
      },
    );
  }
}