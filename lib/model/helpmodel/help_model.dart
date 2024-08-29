class Help {
  final String id;
  final String helpType;
  final String incidentDate;
  final String creditedDate;
  final String creditedAmount;
  final String chequeNumber;
  final String otherRefNumber;
  final String familyMemberName;
  final String lifelineId;
  final String memberName;

  Help({
    required this.id,
    required this.helpType,
    required this.incidentDate,
    required this.creditedDate,
    required this.creditedAmount,
    required this.chequeNumber,
    required this.otherRefNumber,
    required this.familyMemberName,
    required this.lifelineId,
    required this.memberName,
  });

  factory Help.fromJson(Map<String, dynamic> json) {
    return Help(
      id: json['id'].toString(),
      helpType: json['help_type'] ?? '',
      incidentDate: json['incident_date'] ?? '',
      creditedDate: json['credited_date'] ?? '',
      creditedAmount: json['credited_amount'] ?? '',
      chequeNumber: json['cheque_number'] ?? '',
      otherRefNumber: json['other_ref_number'] ?? '',
      familyMemberName: json['family_member_name'] ?? '',
      lifelineId: json['lifeline_id'] ?? '',
      memberName: json['member_name'] ?? '',
    );
  }
}
