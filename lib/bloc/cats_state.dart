import 'package:bloc_tutorial/bloc/cat_http.dart';
import 'package:flutter/foundation.dart';

abstract class CatsState {
  CatsState();
}

class CatsInitial extends CatsState {
  CatsInitial() : super();
}

class CatsLoading extends CatsState {
  CatsLoading() : super();
}

class CatsCompleted extends CatsState {
  final List<Cat> response;

  CatsCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CatsCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends CatsState {
  final String message; 
  CatsError(this.message);
}
