part of 'result_bloc.dart';

class ResultRepository {
  final GraphQLClient graphQLClient;

  ResultRepository({required this.graphQLClient});

  Future<bool> executeCreateCompleteSwimCourseBooking(
      CompleteSwimCourseBookingInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createCompleteSwimCourseBooking),
      variables: {
        'input': input.toGraphqlJson(),
      },
    );

    final QueryResult result = await graphQLClient.mutate(options);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception.toString());
      }
      return false;
    } else {
      if (kDebugMode) {
        print('Mutation erfolgreich');
      }
      return true;
    }
  }

  Future<bool> executeBookingForExistingGuardian(
      NewStudentAndBookingInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createBookingForExistingGuardian),
      variables: {
        'input': input.toGraphqlJson(),
      },
    );

    final QueryResult result = await graphQLClient.mutate(options);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception.toString());
      }
      return false;
    } else {
      if (kDebugMode) {
        print('Mutation erfolgreich');
      }
      return true;
    }
  }

  Future<bool> createContact(CreateContactInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createContact),
      variables: {
        'input': input.toGraphqlJson(),
      },
    );

    final QueryResult result = await graphQLClient.mutate(options);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception.toString());
      }
      return false;
    } else {
      if (kDebugMode) {
        print('Mutation erfolgreich');
      }
      return true;
    }
  }
}
