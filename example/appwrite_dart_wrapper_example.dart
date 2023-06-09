import 'package:appwrite_dart_wrapper/appwrite_dart_wrapper.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
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

Future<void> start(final req, final res) async => await startWrapper(
      req,
      res,
      biz,
      log: true,
      debug: true, // default set false
      debugUserId: 'your-appwrite.io-user-id or null',
    );

Future<Result> biz(
  Map<String, dynamic> headers,
  Map<String, dynamic> payload,
  Map<String, String> vars,
  Client client,
) async {
//   final fnCeateDoc = buildFnCreateRecord(
//     client,
//     databaseId: '<your-db-id>',
//     collectionId: '<your-doc-collection-id>',
//   );

// // use
//   await fnCeateDoc(documentId: ID.unique(), data: {
//     "name": 'test1',
//     "age": 123,
//   });

//  test error report
//   throw "hahaha";
  return Result.rOk(msg: 'Yes Awesome, payloads $payload, vars $vars');
}
