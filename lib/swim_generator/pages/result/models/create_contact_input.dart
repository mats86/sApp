class CreateContactInput {
  final String email;
  String? firstName;
  String? lastName;
  String? sms;
  List<int?> listIds;
  bool emailBlacklisted;
  bool smsBlacklisted;
  bool updateEnabled;
  List<String> smtpBlacklistSender;

  CreateContactInput({
    required this.email,
    this.firstName,
    this.lastName,
    this.sms,
    List<int?>? listIds,
    this.emailBlacklisted = false,
    this.smsBlacklisted = false,
    this.updateEnabled = false,
    List<String>? smtpBlacklistSender,
  })  : listIds = listIds ?? [],
        smtpBlacklistSender = smtpBlacklistSender ?? [];

  Map<String, dynamic> toGraphqlJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'sms': sms,
      'listIds': listIds,
      'emailBlacklisted': emailBlacklisted,
      'smsBlacklisted': smsBlacklisted,
      'updateEnabled': updateEnabled,
      'smtpBlacklistSender': smtpBlacklistSender,
    };
  }
}
