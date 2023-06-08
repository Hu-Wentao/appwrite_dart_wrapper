// 手动配置
import 'dart:convert';

import 'package:appwrite_dart_wrapper/appwrite_dart_wrapper.dart';

import 'appwrite_dart_wrapper_example.dart';

const fnName = 'your_function_name';

main() async {
  localTest(
    fnName,
    start,
    desc: "test function",
    // or use `appwriteJson: jsonDecode(File('../../appwrite.json').readAsStringSync());`
    appwriteJson: {
      "projectId": "your projectId",
      "projectName": "your projectName",
      "teams": [],
      "functions": [
        {
          "\$id": "your_function_id",
          "name": "your_function_name",
          "runtime": "dart-2.17",
          "path": "functions/your_function_name",
          "entrypoint": "lib/main.dart",
          "ignore": [".packages", ".dart_tool", "test.dart"],
          "execute": [],
          "events": [],
          "variables": {
            "APPWRITE_FUNCTION_ENDPOINT": "https://cloud.appwrite.io",
            "APPWRITE_FUNCTION_API_KEY": "your api key",
            "YOUR_VARS": "some-value"
          },
          "schedule": "",
          "timeout": 15
        }
      ]
    },
    req: Req(
      variables: {
        "APPWRITE_FUNCTION_USER_ID": "your-appwrite.io-user-id or null",
      },
      payload: jsonEncode({"test": "value1"}),
    ),
  );
}
