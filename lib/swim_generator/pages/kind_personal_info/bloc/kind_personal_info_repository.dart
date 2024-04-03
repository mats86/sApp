part of 'kind_personal_info_bloc.dart';

class KindPersonalRepository {
  final GraphQLClient graphQLClient;

  KindPersonalRepository({required this.graphQLClient});

  Future<SwimCourseBookingByCode> loadSwimCourseBookingByCode(String bookingCode) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimCourseBooking), // Stellen Sie sicher, dass die Abfrage aktualisiert wurde
      variables: {
        'bookingCode': bookingCode,
      },
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      if (kDebugMode) {
        print("Ausnahme beim Abrufen des SwimCourseBookings: ${result.exception.toString()}");
      }
      throw result.exception!; // Oder eine andere Fehlerbehandlung je nach Ihrer Anwendungslogik
    }

    // Überprüfen Sie, ob Daten vorhanden sind
    if (result.data == null || result.data!['swimCourseBookingByCode'] == null) {
      if (kDebugMode) {
        print("Keine Daten gefunden für den Booking Code: $bookingCode");
      }
      return const SwimCourseBookingByCode.empty(); // Verwenden Sie die leere Instanz
    }

    // Parsen der Daten in das SwimCourseBookingByCode Objekt
    return SwimCourseBookingByCode.fromJson(result.data!['swimCourseBookingByCode']);
  }

}