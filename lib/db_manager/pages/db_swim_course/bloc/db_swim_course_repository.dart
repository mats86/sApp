part of 'db_swim_course_bloc.dart';

class DbSwimCourseRepository {
  final GraphQLClient graphQLClient;

  DbSwimCourseRepository({required this.graphQLClient});

  Future<List<String>> fetchSwimSeason() async {
    return <String>['Laufender Sommer', 'Kommender Sommer'];
  }

  Future<List<SwimCourse>> getSwimCourses() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCourses),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    List<dynamic> coursesJson = result.data!['swimCourses'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => SwimCourse.fromJson(json)).toList();
  }

  Future<SwimCourse> getSwimCourseById(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCourseById),
      variables: {'id': id},
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }

    return SwimCourse.fromJson(result.data!['swimCourseById']);
  }

  Future<List<SwimCourse>> getSwimCoursesByLevelAndFutureAge(
      int swimLevelId, DateTime birthdate, DateTime futureDate) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCoursesByLevelAndFutureAge),
      variables: {
        'swimLevelId': swimLevelId,
        'birthdate': birthdate.toIso8601String(),
        'futureDate': futureDate.toIso8601String(),
      },
    );

    final result = await graphQLClient.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    // Hier nehmen wir an, dass die Antwort eine Liste von Kursen ist
    List<dynamic> coursesJson = result.data!['swimCoursesByLevelAndFutureAge'];

    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => SwimCourse.fromJson(json)).toList();
  }

  Future<List<SwimCourse>> getSwimCoursesByLevelNameAndFutureAge(
      String swimLevelName, DateTime birthdate, DateTime futureDate) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCoursesByLevelNameAndFutureAge),
      variables: {
        'swimLevelName': swimLevelName,
        'birthdate': birthdate.toIso8601String(),
        'futureDate': futureDate.toIso8601String(),
      },
    );

    final result = await graphQLClient.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    // Hier nehmen wir an, dass die Antwort eine Liste von Kursen ist
    List<dynamic> coursesJson =
    result.data!['swimCoursesByLevelNameAndFutureAge'];

    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => SwimCourse.fromJson(json)).toList();
  }
}
