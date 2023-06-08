import 'dart:convert';
import 'dart:io';

localTest(
  String fnName,
  Future Function(Req req, Res res) start, {
  Req req = const Req(),
  Res res = const Res(),
  String desc = '',
}) async {
  print("localTest ===== $desc");
  final appwriteJson =
      jsonDecode(File('../../appwrite.json').readAsStringSync());
  final projId = appwriteJson['projectId'];
  final funcLs = appwriteJson['functions'] as List<dynamic>;
  final env = funcLs.firstWhere((e) => e['name'] == fnName)['variables'];
  await start(
    Req(
      headers: req.headers,
      variables: {
        ...env,
        "APPWRITE_FUNCTION_PROJECT_ID": "$projId",
        ...req.variables,
      },
      payload: req.payload,
    ),
    res,
  );
}

class Req {
  final Map<String, dynamic> headers;
  // runtime 内部是<String, dynamic>,但Appwrite只允许配置String类型的环境变量
  final Map<String, dynamic> variables;
  final String payload;

  const Req({
    this.headers = const {},
    this.variables = const {},
    this.payload = '{}',
  });
}

class Res {
  final Function(String body, int status)? onData;
  const Res({this.onData});
  json(Map json, [int status = 200]) => send('$json', status);
  send(String body, [int status = 200]) {
    onData?.call(body, status);
    print("res# body: $body, status: $status");
  }
}
