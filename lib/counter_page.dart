import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tut_block/counter_bloc.dart';
import 'package:tut_block/generated/i18n.dart';


class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.display1,
                ),
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
              child: Icon(Icons.add),
              tooltip: S.of(context).tooltipInc,
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              tooltip: S.of(context).tooltipDec,
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}