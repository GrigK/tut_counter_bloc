import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tut_block/counter/counter_page.dart';
import 'package:tut_block/counter/counter_bloc.dart';
import 'package:tut_block/generated/i18n.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /// у Stateless виджета нет dispose
    /// а по хорошему нужно делать:
    ///  var _counterBloc;
    ///  void init() { _counterBloc = BlocProvider.of<CounterBloc>(context); }
    ///  void dispose() { _counterBloc.close(); }
    ///  однако нам надо передать экзкмпляр CounterBloc на вторую страницу

    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<CounterPage>(
                builder: (context) {
                  /// в качестве value необходимо передать экземпляр
                  /// существующего CounterBloc чтоб его можно было использовать
                  /// на другой странице
                  return BlocProvider.value(
                    key: UniqueKey(),
                    value: counterBloc,
                    child: CounterPage(),
                  );
                },
              ),
            );
          },
          child: Text(S.of(context).btnCounter),
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 1,
              child: Icon(Icons.add),
              onPressed: () {
                counterBloc.add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 0,
              child: Icon(Icons.remove),
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
