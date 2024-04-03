part of 'swim_school_bloc.dart';

class SwimSchoolRepository {
  final GraphQLClient graphQLClient;

  SwimSchoolRepository({required this.graphQLClient});

  Future<List<SwimSchool>> fetchSwimSchools() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimSchools),
    );

    final result = await graphQLClient.query(options);

    // Check for exceptions and throw if any
    if (result.hasException) {
      if (kDebugMode) {
        print("Exception while fetching SwimSchools: ${result.exception.toString()}");
      }
      throw result.exception!;
    }

    // Check if data exists
    if (result.data == null || result.data!['swimSchools'] == null) {
      if (kDebugMode) {
        print("No data found");
      }
      return [];
    }

    List<dynamic> swimSchoolsJson = result.data!['swimSchools'];

    // Convert each JSON entry into a SwimSchool object
    return swimSchoolsJson.map((json) => SwimSchool.fromJson(json)).toList();
  }

}
