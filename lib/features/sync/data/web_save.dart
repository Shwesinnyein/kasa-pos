import 'dart:async';

import 'package:drift/drift.dart';

class WebSaveHub {
  var paused = false;
  void Function()? onWrite;
  Timer? _timer;

  void poke() {
    if (paused) return;
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () => onWrite?.call());
  }
}

final webSaveHub = WebSaveHub();

class WebSaveInterceptor extends QueryInterceptor {
  WebSaveInterceptor(this.hub);

  final WebSaveHub hub;

  @override
  Future<int> runInsert(QueryExecutor executor, String statement, List<Object?> args) async {
    final result = await executor.runInsert(statement, args);
    hub.poke();
    return result;
  }

  @override
  Future<int> runUpdate(QueryExecutor executor, String statement, List<Object?> args) async {
    final result = await executor.runUpdate(statement, args);
    hub.poke();
    return result;
  }

  @override
  Future<int> runDelete(QueryExecutor executor, String statement, List<Object?> args) async {
    final result = await executor.runDelete(statement, args);
    hub.poke();
    return result;
  }

  @override
  Future<void> runBatched(QueryExecutor executor, BatchedStatements statements) async {
    await executor.runBatched(statements);
    hub.poke();
  }
}
