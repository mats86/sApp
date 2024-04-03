part of 'result_bloc.dart';

class ResultRepository {
  final GraphQLClient graphQLClient;

  ResultRepository({required this.graphQLClient});

  Future<SwimCourseBookingResult> executeCreateCompleteSwimCourseBooking(
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
      return SwimCourseBookingResult(
        isSuccess: false,
        errorMessage: result.exception.toString(),
      );
    } else {
      if (kDebugMode) {
        print('Mutation erfolgreich');
      }
      return SwimCourseBookingResult(
        isSuccess: true,
        swimCourseBookingData: result.data != null
            ? SwimCourseBookingData.fromJson(
                result.data?['createCompleteSwimCourseBooking'])
            : null,
      );
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

  Future<bool> createOrUpdateContact(CreateContactInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createOrUpdateContact),
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

  Future<bool> createContacts(CreateContactsInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createContacts),
      variables: {
        'input': input.toGraphqlJson(),
      },
    );

    try {
      final QueryResult result = await graphQLClient.mutate(options);

      if (result.hasException) {
        if (kDebugMode) {
          print(result.exception.toString());
        }
        throw Exception('Failed to create contacts');
      } else {
        if (kDebugMode) {
          print('Mutation erfolgreich');
        }
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
