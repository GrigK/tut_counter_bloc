import 'dart:async';
import 'package:bloc/bloc.dart';

/// События для счетчика
/// Поскольку счетчик представлен всего одним числом то
/// класс состояний создавать не будем
enum CounterEvent { increment, decrement }


class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {

    switch(event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
    }
  }
}