part of 'parent_personal_info_bloc.dart';

class ParentPersonalInfoRepository {
  final GraphQLClient graphQLClient;

  ParentPersonalInfoRepository({required this.graphQLClient});

  Future<List<String>> _fetchTitle() async {
    return <String>['Frau', 'Herr'];
  }

  Future<bool> checkEmail(String email) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.checkEmailAndThrowErrorIfExists),
      variables: {
        'loginEmail': email,
      },
    );

    final result = await graphQLClient.query(options);

    if (result.hasException) {
      // Behandlung von Netzwerkfehlern oder anderen Anfragefehlern
      throw result.exception!;
    }
    return result.data!['checkEmailAndThrowErrorIfExists'] as bool;
  }
}
