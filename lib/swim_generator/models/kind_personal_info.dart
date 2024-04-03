import 'package:equatable/equatable.dart';

import '../pages/kind_personal_info/bloc/kind_personal_info_bloc.dart';

class KindPersonalInfo extends Equatable {
  final List<ChildInfo> childInfos;
  final List<ChildInfo> childInfosNoEmpty;
  final ChildInfo childInfo;
  final List<CustomerInvitedInfo> customerInvitedInfos;
  final List<CustomerInvitedInfo> customerInvitedInfosNoEmpty;

  const KindPersonalInfo({
    required this.childInfos,
    required this.childInfosNoEmpty,
    required this.childInfo,
    required this.customerInvitedInfos,
    required this.customerInvitedInfosNoEmpty,
  });

  const KindPersonalInfo.empty()
      : this(
          childInfos: const [],
          childInfosNoEmpty: const [],
          childInfo: const ChildInfo(),
          customerInvitedInfos: const [],
          customerInvitedInfosNoEmpty: const [],
        );

  KindPersonalInfo copyWith({
    List<ChildInfo>? childInfos,
    List<ChildInfo>? childInfosNoEmpty,
    ChildInfo? childInfo,
    List<CustomerInvitedInfo>? customerInvitedInfos,
    List<CustomerInvitedInfo>? customerInvitedInfosNoEmpty,
  }) {
    return KindPersonalInfo(
      childInfos: childInfos ?? this.childInfos,
      childInfosNoEmpty: childInfosNoEmpty ?? this.childInfosNoEmpty,
      childInfo: childInfo ?? this.childInfo,
      customerInvitedInfos: customerInvitedInfos ?? this.customerInvitedInfos,
      customerInvitedInfosNoEmpty:
          customerInvitedInfosNoEmpty ?? this.customerInvitedInfosNoEmpty,
    );
  }

  bool get isEmpty {
    return childInfos.isEmpty && customerInvitedInfos.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object> get props => [
        childInfos,
        childInfosNoEmpty,
        childInfo,
        customerInvitedInfos,
        customerInvitedInfosNoEmpty,
      ];
}
