import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

typedef FnOptExecution = Future<Execution> Function({
  required Map<String, dynamic> data,
  bool? xasync2,
});

FnOptExecution buildExecution(
  Client c, {
  required String idFn,
  required String funName,
  bool xasync = false, // 转账默认 false, 可以查询错误
}) =>
    ({
      required Map<String, dynamic> data,
      bool? xasync2, // 二次修改
    }) async =>
        await Functions(c).createExecution(
            functionId: idFn,
            xasync: xasync2 ?? xasync,
            data: jsonEncode(data));
