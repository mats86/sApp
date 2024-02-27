part of 'date_selection_bloc.dart';

class DateSelectionRepository {
  final GraphQLClient graphQLClient;

  DateSelectionRepository({required this.graphQLClient});

  Future<List<FixDate>> loadFixDates(int swimCourseID, List<int> swimPoolIDs) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getFixDatesBySwimCourseIDAndSwimPoolIDs),
      variables: {
        'swimCourseID': swimCourseID,
        'swimPoolIDs': swimPoolIDs
      },
    );
    final result = await graphQLClient.query(options);
    if (result.hasException) {
      if (kDebugMode) {
        print(
            "Ausnahme beim Abrufen von SwimPools: ${result.exception.toString()}");
      }
      throw result.exception!;
    }

    // Überprüfen Sie, ob Daten vorhanden sind
    if (result.data == null || result.data!['fixDatesBySwimCourseIDAndSwimPoolIDs'] == null) {
      if (kDebugMode) {
        print("Keine Daten gefunden");
      }
      return [];
    }

    List<dynamic> swimPoolsJson = result.data!['fixDatesBySwimCourseIDAndSwimPoolIDs'];
    return swimPoolsJson.map((json) => FixDate.fromJson(json)).toList();
  }
}