part of 'swim_pool_bloc.dart';

class SwimPoolRepository {
  final GraphQLClient graphQLClient;

  SwimPoolRepository({required this.graphQLClient});

  Future<List<SwimPool>> fetchSwimPools() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimPools),
    );

    final result = await graphQLClient.query(options);

    // Überprüfen Sie, ob eine Ausnahme vorliegt, und werfen Sie diese gegebenenfalls
    if (result.hasException) {
      if (kDebugMode) {
        print(
            "Ausnahme beim Abrufen von SwimPools: ${result.exception.toString()}");
      }
      throw result.exception!;
    }

    // Überprüfen Sie, ob Daten vorhanden sind
    if (result.data == null || result.data!['swimPools'] == null) {
      if (kDebugMode) {
        print("Keine Daten gefunden");
      }
      return [];
    }

    List<dynamic> swimPoolsJson = result.data!['swimPools'];

    // Konvertieren Sie jeden JSON-Eintrag in ein SwimPool-Objekt
    return swimPoolsJson.map((json) => SwimPool.fromJson(json)).toList();
  }

  Future<List<SwimPool>> fetchSwimCourseSwimPools(int swimCourseID) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCourseSwimPools),
      variables: {'swimCourseID': swimCourseID},
    );

    final result = await graphQLClient.query(options);

    // Überprüfen Sie, ob eine Ausnahme vorliegt, und werfen Sie diese gegebenenfalls
    if (result.hasException) {
      if (kDebugMode) {
        print(
            "Ausnahme beim Abrufen von SwimPools: ${result.exception.toString()}");
      }
      throw result.exception!;
    }

    // Überprüfen Sie, ob Daten vorhanden sind
    if (result.data == null || result.data!['swimCourseSwimPools'] == null) {
      if (kDebugMode) {
        print("Keine Daten gefunden");
      }
      return [];
    }

    List<dynamic> swimPoolsJson = result.data!['swimCourseSwimPools'];

    // Konvertieren Sie jeden JSON-Eintrag in ein SwimPool-Objekt
    return swimPoolsJson.map((json) => SwimPool.fromJson(json)).toList();
  }
}
