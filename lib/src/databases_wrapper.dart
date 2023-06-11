import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

///
typedef FnOptRecord = Future<Document> Function({
  required String documentId,
  Map<dynamic, dynamic>? data,
});

/// Query
Future<DocumentList> Function(List<String>) buildFnQueryRecord(
  Client client, {
  required String databaseId,
  required String collectionId,
}) =>
    (List<String> queries) => Databases(client).listDocuments(
          databaseId: databaseId,
          collectionId: collectionId,
          queries: queries,
        );

/// Create
FnOptRecord buildFnCreateRecord(
  Client client, {
  required String databaseId,
  required String collectionId,
}) =>
    ({
      required String documentId,
      List<String>? permissions,
      Map<dynamic, dynamic>? data,
    }) =>
        Databases(client).createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          permissions: permissions,
          data: data ?? {},
        );

/// Update
FnOptRecord buildFnUpdateRecord(
  Client client, {
  required String databaseId,
  required String collectionId,
}) =>
    ({
      required String documentId,
      List<String>? permissions,
      Map<dynamic, dynamic>? data,
    }) =>
        Databases(client).updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          permissions: permissions,
          data: data,
        );

/// Get
FnOptRecord buildFnGetRecord(
  Client client, {
  required String databaseId,
  required String collectionId,
}) =>
    ({
      required String documentId,
      Map<dynamic, dynamic>? data,
    }) =>
        Databases(client).getDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
        );
