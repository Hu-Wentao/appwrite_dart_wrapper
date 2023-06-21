import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:get_it/get_it.dart';

typedef BizFun = Future<Result> Function(
  Map<String, dynamic> headers,
  Map<String, dynamic> payload,
  Map<String, String> vars,
);

/// [debugUserId] set null or uid, Preventing malicious override of [vars]
Future<void> starter(
  req,
  res,
  BizFun biz, {
  bool log = true,
  bool debug = false,
  String? debugUserId,
}) async {
  try {
    //  payload
    final Map<String, dynamic> payload =
        (req.payload as String?)?.isEmpty ?? true
            ? {}
            : jsonDecode(req.payload);
    log = payload['log'] as bool? ?? log;
    debug = payload['debug'] as bool? ?? debug;
    //  variables
    final variables = <String, String>{
      for (final e in (req.variables as Map).entries) '${e.key}': '${e.value}',
    };
    if (debug) {
      if (debugUserId == variables['APPWRITE_FUNCTION_USER_ID']) {
        variables
            .addAll({for (final p in payload.entries) p.key: '${p.value}'});
      } else {
        throw "UnSupport `debug=true`,Because debugUserId is: ${debugUserId == null ? 'null' : 'not equal APPWRITE_FUNCTION_USER_ID'}";
      }
    }

    //
    if (debug || log) {
      print(
        [
          'debug $debug, log $log',
          'log req.headers ${req.headers}',
          'log req.payload ${req.payload}',
          if (debug)
            'log req.variables ${Map.from({
                  ...variables,
                  'APPWRITE_FUNCTION_API_KEY': '==hide=='
                })}'
        ].join('\n'),
      );
    }
    //
    final map = (await biz(req.headers, payload, variables)).toJson();

    //
    if (debug || log) print('log rst $map');
    return res.json(map);
  } catch (e, s) {
    res.json(Result.rErr('[${req.variables['APPWRITE_FUNCTION_NAME']}]#\n$e', s)
        .toJson());
  }
}

/// starter with GetIt
Future<void> startWithGetIt(
  req,
  res, {
  GetIt? getIt,
  required Future<void> Function(GetIt g) initDI,
  required BizFun Function(GetIt g) setBiz,
  bool log = true,
  bool debug = false,
  String? debugUserId,
}) async {
  await starter(
    req,
    res,
    (headers, payload, vars) async {
      final g = getIt ?? GetIt.I;
      await initDI(g);
      return await (setBiz(g).call(headers, payload, vars));
    },
    log: log,
    debug: debug,
    debugUserId: debugUserId,
  );
}

/// [debugUserId] set null or uid, Preventing malicious override of [vars]
Future<void> startWrapper(
  req,
  res,
  Future<Result> Function(
    Map<String, dynamic> headers,
    Map<String, dynamic> payload,
    Map<String, String> vars,
    Client client,
  )
      biz, {
  bool log = true,
  bool debug = false,
  String? debugUserId,
}) async =>
    await starter(
      req,
      res,
      (headers, payload, vars) async => await biz(
        headers,
        payload,
        vars,
        withClient(req, res),
      ),
      log: log,
      debug: debug,
      debugUserId: debugUserId,
    );

class Result {
  final bool ok;
  final Object? msg;
  final Map<String, Object?>? data;
  final StackTrace? trace;

  const Result({
    this.ok = true,
    this.msg,
    this.trace,
    this.data,
  });

  const Result.rOk({this.msg, this.data})
      : ok = true,
        trace = null;

  const Result.rErr(this.msg, this.trace, {this.data}) : ok = false;

  Map<String, dynamic> toJson() => {
        'ok': ok,
        if (msg != null) "msg": "$msg",
        if (trace != null) "trace": "$trace",
        if (data != null) "data": data,
      };
}

/// 获取服务端Client
Client withClient(final req, final res) {
  // 用于创建 Appwrite Server端Client
  final endPoint = req.variables['APPWRITE_FUNCTION_ENDPOINT'] as String? ??
      (throw "variables `APPWRITE_FUNCTION_ENDPOINT` can not be null");
  final apiKey = req.variables['APPWRITE_FUNCTION_API_KEY'] as String? ??
      (throw "variables `APPWRITE_FUNCTION_API_KEY` can not be null");
  final projId = req.variables['APPWRITE_FUNCTION_PROJECT_ID'] as String? ??
      (throw "variables `APPWRITE_FUNCTION_PROJECT_ID` can not be null");

  return Client().setEndpoint(endPoint).setProject(projId).setKey(apiKey);
}
