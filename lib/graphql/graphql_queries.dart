class GraphQLQueries {
  static const String getSwimCourses = '''
  query getSwimCourses() {
    swimCourses() {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
      swimCourseStartBooking
      swimCourseEndBooking
      swimCourseStartVisible
      swimCourseEndVisible
      swimCourseUrl
      isAdultCourse
      isGroupCourse
    }
  }
''';

  static const String getSwimCourseById = '''
  query getSwimCourseById(\$swimCourseID: Int!) {
    swimCourseById(swimCourseID: \$swimCourseID) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
      swimCourseStartBooking
      swimCourseEndBooking
      swimCourseStartVisible
      swimCourseEndVisible
      swimCourseUrl
      isAdultCourse
      isGroupCourse
    }
  }
''';

  static const String getSwimCoursesByLevelAndFutureAge = '''
  query getSwimCoursesByLevelAndFutureAge(\$swimLevelID: Int!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelAndFutureAge(swimLevelID: \$swimLevelID, birthdate: \$birthdate, futureDate: \$futureDate) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
      swimCourseStartBooking
      swimCourseEndBooking
      swimCourseStartVisible
      swimCourseEndVisible
      swimCourseUrl
      isAdultCourse
      isGroupCourse
    }
  }
''';

  static const String getSwimCoursesByLevelNameAndFutureAge = '''
  query getSwimCoursesByLevelNameAndFutureAge(\$swimLevelName: String!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    swimCoursesByLevelNameAndFutureAge(swimLevelName: \$swimLevelName, birthdate: \$birthdate, futureDate: \$futureDate) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCoursePrice
      swimCourseDescription
      swimCourseDateTypID
      swimCourseDuration
      isSwimCourseVisible
      swimLevelID
      swimCourseStartBooking
      swimCourseEndBooking
      swimCourseStartVisible
      swimCourseEndVisible
      swimCourseUrl
      isAdultCourse
      isGroupCourse
    }
  }
''';

  static const String getSwimPools = '''
  query getSwimPools {
    swimPools {
      swimPoolID
      swimPoolName
      swimPoolAddress
      swimPoolPhoneNumber
      swimPoolOpeningTimes {
        day
        openTime
        closeTime
      }
      swimPoolHasFixedDate
      isSwimPoolVisible
    }
  }
''';
  static const String getSwimCourseSwimPools = '''
  query getSwimCourseSwimPools(\$swimCourseID: Int!) {
    swimCourseSwimPools(swimCourseID: \$swimCourseID) {
      swimPoolID
      swimPoolName
      swimPoolAddress
      swimPoolPhoneNumber
      swimPoolOpeningTimes {
        day
        openTime
        closeTime
      }
      swimPoolHasFixedDate
      isSwimPoolVisible
    }
  }
''';

  static const String createCompleteSwimCourseBooking = '''
  mutation createCompleteSwimCourseBooking(\$input: CompleteSwimCourseBookingInput!) {
    createCompleteSwimCourseBooking(input: \$input) {
      swimCourseBookingID
      swimCourseID
    }
  }
''';

  static const String createBookingForExistingGuardian = '''
  mutation createBookingForExistingGuardian(\$input: NewStudentAndBookingInput!) {
    createBookingForExistingGuardian(input: \$input) {
      swimCourseBookingID
      swimCourseID
      studentID
      guardianID
    }
  }
''';

  static const String createContact = '''
    mutation CreateContact(\$input: CreateContactInput!) {
      createContact(input: \$input) {
        id
      }
    }
  ''';

  static const String getFixDates = '''
    query getFixDates {
      fixDates {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesWithDetails = '''
    query getFixDatesWithDetails {
      fixDatesWithDetails {
        fixDateID
        swimCourseID
        swimCourseName
        swimPoolID
        swimPoolName
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimCourseID = '''
    query getFixDatesBySwimCourseID(\$swimCourseID: Int!) {
      fixDatesBySwimCourseID(swimCourseID: \$swimCourseID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimPoolID = '''
    query getFixDatesBySwimPoolID(\$swimPoolID: Int!) {
      fixDatesBySwimPoolID(swimPoolID: \$swimPoolID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimCourseIDAndSwimPoolID = '''
    query getFixDatesBySwimCourseIDAndSwimPoolID(\$swimCourseID: Int!, \$swimPoolID: Int!) {
      fixDatesBySwimCourseIDAndSwimPoolID(swimCourseID: \$swimCourseID, swimPoolID: \$swimPoolID) {
        fixDateID
        swimCourseID
        swimPoolID
        fixDateFrom
        fixDateTo
        isFixDateActive
      }
    }
  ''';

  static const String getFixDatesBySwimCourseIDAndSwimPoolIDs = '''
  query getFixDatesBySwimCourseIDAndSwimPoolIDs(\$swimCourseID: Int!, \$swimPoolIDs: [Int!]!) {
    fixDatesBySwimCourseIDAndSwimPoolIDs(swimCourseID: \$swimCourseID, swimPoolIDs: \$swimPoolIDs) {
      fixDateID
      swimCourseID
      swimPoolID
      fixDateFrom
      fixDateTo
      isFixDateActive
    }
  }
''';

  static const String checkEmailAndThrowErrorIfExists = '''
    query checkEmailAndThrowErrorIfExists(\$loginEmail: String!) {
      checkEmailAndThrowErrorIfExists(loginEmail: \$loginEmail)
    }
  ''';
}
