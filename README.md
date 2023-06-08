<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

- startWrapper
log req.headers, req.payload;
parse req to headers, payload, vars,

- databases_wrapper
Provide closure functions for Create, Update, Get, Query Document.

- functions_wrapper
Provide closure functions for Create Execution


## Getting started

```shell
dart pub add appwrite_dart_wrapper
```

## Usage

/// just paste to main.dart
```dart
import 'package:appwrite_dart_wrapper/appwrite_dart_wrapper.dart';

Future<void> start(final req, final res) async =>
    await startWrapper(req, res, biz,
        log: true, debugUserId: '<`your appwrite admin user id` or `null`>',
        );
```

## Additional information

### Function variables
Function variables supplied by Appwrite in addition to your own defined function variables that you can access from your function code. These variables give you information about your execution runtime environment.

Name	Description
- APPWRITE_FUNCTION_ID
Your function's unique ID.

- **APPWRITE_FUNCTION_NAME**	Your function's name.

- APPWRITE_FUNCTION_DEPLOYMENT	Your function's code deployment unique ID.

- **APPWRITE_FUNCTION_TRIGGER**	Either 'event' when triggered by one of the selected scopes, 'http' when triggered by an HTTP request or the - Appwrite Console, or 'schedule' when triggered by the cron schedule.

- APPWRITE_FUNCTION_RUNTIME_NAME	Your function runtime name. Can be any of Appwrite supported execution runtimes.

- APPWRITE_FUNCTION_RUNTIME_VERSION	Your function runtime version.

- **APPWRITE_FUNCTION_EVENT**
无法用于 函数触发, 只能用于 事件触发
Your function event name. This value is available only when your function trigger is 'event.' This variable value can be any of Appwrite system events.

- APPWRITE_FUNCTION_EVENT_DATA	Your function event payload. This value is available only when your function trigger is 'event'. This variable value contains a string in JSON format with your specific event data.

- **APPWRITE_FUNCTION_DATA**
无法用于 事件触发, 只能用于HTTP/SDK/Console触发
Your function's custom execution data. This variable's value contains a string in any format. If the custom data is in JSON FORMAT, it must be parsed inside the function code. Note that this variable can be set only when triggering a function using the SDK or HTTP API and the Appwrite Dashboard.

- **APPWRITE_FUNCTION_PROJECT_ID**
Your function's project ID.

- **APPWRITE_FUNCTION_USER_ID**
The userId of the user that triggered your function's execution. Executions triggered in the Appwrite console will be prepended with "admin-".

- APPWRITE_FUNCTION_JWT
A JSON Web Token generated for the user that executes your function.