class GraphQLQueries {
  static const String getSwimSchools = '''
    query getSwimSchools {
      swimSchools {
        swimSchoolID
        swimSchoolName
        swimSchoolUrl
      }
    }
''';

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

  static const String getVisibleSwimCoursesByLevelNameAndFutureAge = '''
  query getVisibleSwimCoursesByLevelNameAndFutureAge(\$swimLevelName: String!, \$birthdate: DateTime!, \$futureDate: DateTime!) {
    visibleSwimCoursesByLevelNameAndFutureAge(swimLevelName: \$swimLevelName, birthdate: \$birthdate, futureDate: \$futureDate) {
      swimCourseID
      swimCourseName
      swimCourseMinAge
      swimCourseMaxAge
      swimCourseGroupSize
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
      swimSchoolID
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

  static const String getSwimPoolsBySwimSchool = '''
  query getSwimPoolsBySwimSchool(\$swimSchoolID: Int!) {
    swimPoolsBySwimSchool(swimSchoolID: \$swimSchoolID) {
      swimPoolID
      brevoListId
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
      bookingDate
      paymentStatus
      referenceBooking
      bookingDateTypID
      isWaitList
      inviteCode
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

  static const String createOrUpdateContact = '''
    mutation createOrUpdateContact(\$input: CreateContactInput!) {
      createOrUpdateContact(input: \$input) {
        id
      }
    }
  ''';

  static const String createContacts = '''
    mutation createContacts(\$input: CreateContactsInput!) {
      createContacts(input: \$input) {
        results {
          success
          customerEmail
          message
        }
      }
    }
  ''';

  static const String getSwimCourseBooking = '''
  query GgtSwimCourseBooking(\$bookingCode: String!) {
    swimCourseBookingByCode(bookingCode: \$bookingCode) {
      swimCourseBookingID
      swimCourse {
        swimCourseID
        swimCourseName
        swimCourseMinAge
        swimCourseMaxAge
        swimCourseGroupSize
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
      fixDateID
      bookingDateTypID
      referenceBooking
      swimPools {
        swimPoolID
        brevoListId
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

  static const String getFixDatesSortedBySwimPoolIDAndFixDateFrom = '''
  query getFixDatesSortedBySwimPoolIDAndFixDateFrom(\$swimCourseID: Int!, \$swimPoolIDs: [Int!]!) {
    fixDatesSortedBySwimPoolIDAndFixDateFrom(swimCourseID: \$swimCourseID, swimPoolIDs: \$swimPoolIDs) {
      fixDateID
      swimCourseID
      swimPoolID
      fixDateFrom
      fixDateTo
      isFixDateActive
    }
  }
''';

  static const String getFixDatesSortedBySwimPoolIDAndFixDateFromActive = '''
  query getFixDatesSortedBySwimPoolIDAndFixDateFromActive(\$swimCourseID: Int!, \$swimPoolIDs: [Int!]!) {
    fixDatesSortedBySwimPoolIDAndFixDateFromActive(swimCourseID: \$swimCourseID, swimPoolIDs: \$swimPoolIDs) {
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
