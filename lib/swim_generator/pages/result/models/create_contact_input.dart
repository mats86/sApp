import '../../kind_personal_info/bloc/kind_personal_info_bloc.dart';

class CreateContactInput {
  final String email;
  String? firstName;
  String? lastName;
  String? sms;
  String? whatsapp;
  String? childFirstName;
  String? childBirthDay;
  List<int?> listIds;
  bool emailBlacklisted;
  bool smsBlacklisted;
  bool updateEnabled;
  String? swimCourse;
  String? swimPool;
  String? fixDate;
  bool? isWaitList;
  List<String> smtpBlacklistSender;

  CreateContactInput({
    required this.email,
    this.firstName,
    this.lastName,
    this.sms,
    this.whatsapp,
    this.childFirstName,
    this.childBirthDay,
    List<int?>? listIds,
    this.emailBlacklisted = false,
    this.smsBlacklisted = false,
    this.updateEnabled = false,
    this.swimCourse,
    this.swimPool,
    this.fixDate,
    this.isWaitList,
    List<String>? smtpBlacklistSender,
  })  : listIds = listIds ?? [],
        smtpBlacklistSender = smtpBlacklistSender ?? [];

  Map<String, dynamic> toGraphqlJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'sms': sms,
      'whatsapp': whatsapp,
      'childFirstName': childFirstName,
      'childBirthDay': childBirthDay,
      'listIds': listIds,
      'emailBlacklisted': emailBlacklisted,
      'smsBlacklisted': smsBlacklisted,
      'updateEnabled': updateEnabled,
      'smtpBlacklistSender': smtpBlacklistSender,
      'swimCourse': swimCourse,
      'swimPool': swimPool,
      'fixDate': fixDate,
      'isWaitList': isWaitList,
    };
  }
}


class CreateContactsInput {
  List<int?> listIds;
  bool emailBlacklisted;
  bool smsBlacklisted;
  bool updateEnabled;
  String? swimCourse;
  String? swimPool;
  String? fixDate;
  bool? isWaitList;
  String? inviteCode;
  List<String> smtpBlacklistSender;
  List<CustomerInvitedInfo> customerInvitedInfos;

  CreateContactsInput({
    List<int?>? listIds,
    this.emailBlacklisted = false,
    this.smsBlacklisted = false,
    this.updateEnabled = false,
    this.swimCourse,
    this.swimPool,
    this.fixDate,
    this.isWaitList,
    this.inviteCode,
    List<String>? smtpBlacklistSender,
    List<CustomerInvitedInfo>? customerInvitedInfos,
  })  : listIds = listIds ?? [],
        smtpBlacklistSender = smtpBlacklistSender ?? [],
        customerInvitedInfos = customerInvitedInfos ?? [];

  Map<String, dynamic> toGraphqlJson() {
    return {
      'listIds': listIds,
      'emailBlacklisted': emailBlacklisted,
      'smsBlacklisted': smsBlacklisted,
      'updateEnabled': updateEnabled,
      'smtpBlacklistSender': smtpBlacklistSender,
      'swimCourse': swimCourse,
      'swimPool': swimPool,
      'fixDate': fixDate,
      'isWaitList': isWaitList,
      'customersInvited': customerInvitedInfos,
      'inviteCode': inviteCode,
    };
  }
}

class CreateContactResult {
  final bool success;
  final String? customerEmail;
  final String? message;

  CreateContactResult({required this.success, this.customerEmail, this.message});

  factory CreateContactResult.fromJson(Map<String, dynamic> json) {
    return CreateContactResult(
      success: json['Success'],
      customerEmail: json['CustomerEmail'],
      message: json['Message'],
    );
  }
}

class CreateContactsResult {
  final List<CreateContactResult> results;

  CreateContactsResult({required this.results});

  factory CreateContactsResult.fromJson(Map<String, dynamic> json) {
    var list = json['Results'] as List;
    List<CreateContactResult> resultsList = list.map((i) => CreateContactResult.fromJson(i)).toList();
    return CreateContactsResult(results: resultsList);
  }
}

