part of 'db_fix_date_bloc.dart';

class DbFixDateRepository {
  final GraphQLClient graphQLClient;

  DbFixDateRepository({required this.graphQLClient});

  Future<List<FixDate>> getFixDates() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getFixDates),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    List<dynamic> coursesJson = result.data!['fixDates'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => FixDate.fromJson(json)).toList();
  }

  Future<List<FixDateDetail>> getFixDatesWithDetails() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getFixDatesWithDetails),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    List<dynamic> coursesJson = result.data!['fixDatesWithDetails'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => FixDateDetail.fromJson(json)).toList();
  }

  Future<List<SwimCourse>> getSwimCourses() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries
          .getSwimCourses), // Stellen Sie sicher, dass Sie die korrekte Query hier haben
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    List<dynamic> jsonList = result.data!['swimCourses'] as List<dynamic>;
    return jsonList.map((json) => SwimCourse.fromJson(json)).toList();
  }
}
