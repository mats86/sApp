part of 'birth_day_bloc.dart';

class BirthDayRepository {
  final GraphQLClient graphQLClient;

  BirthDayRepository({required this.graphQLClient});

  Future<SwimCourse> getSwimCourseById(int swimCourseID) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCourseById),
      variables: {'swimCourseID': swimCourseID},
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return SwimCourse.fromJson(result.data!['swimCourseById']);
  }
}
