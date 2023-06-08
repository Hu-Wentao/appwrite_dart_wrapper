import 'package:appwrite_dart_wrapper/appwrite_dart_wrapper.dart';
import 'package:dart_appwrite/src/client.dart';

Future<void> main() async {
  await start(
      Req(variables: {
        "APPWRITE_FUNCTION_ENDPOINT": "https://api.appwrite.io",
        "APPWRITE_FUNCTION_PROJECT_ID": "your project id",
        "APPWRITE_FUNCTION_API_KEY": "your project key"
      }), Res(onData: (awesome, s) {
    print("awsome: $awesome");
  }));
}

Future<void> start(final req, final res) async =>
    await startWrapper(req, res, biz,
        log: true, debugUserId: '645b9f20cedaa8e07ff8');

Future<Result> biz(
  Map<String, dynamic> headers,
  Map<String, dynamic> payload,
  Map<String, String> vars,
  Client client,
) async {
  return Result.rOk(msg: 'Yes Awesome');
}
