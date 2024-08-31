// member_details.dart
class MemberDetails {
  final int id;
  final int districtId;
  final String districtName;
  final String lifelineId;
  final String name;
  final String username;
  final String mobile;
  final String upiId;
  final String image;
  final String signature;
  final String dateOfBirth;
  final String place;
  final String address;
  final String aadhaarNumber;

  MemberDetails({
    required this.id,
    required this.districtId,
    required this.districtName,
    required this.lifelineId,
    required this.name,
    required this.username,
    required this.mobile,
    required this.upiId,
    required this.image,
    required this.signature,
    required this.dateOfBirth,
    required this.place,
    required this.address,
    required this.aadhaarNumber,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    return MemberDetails(
      id: json['id'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      lifelineId: json['lifeline_id'],
      name: json['name'],
      username: json['username'],
      mobile: json['mobile'],
      upiId: json['upi_id'],
      image: json['image'],
      signature: json['signature'],
      dateOfBirth: json['date_of_birth'],
      place: json['place'],
      address: json['address'],
      aadhaarNumber: json['aadhaar_number'],
    );
  }
}

// family_details.dart
class FamilyDetails {
  final int id;
  final bool isHead;
  final int memberId;
  final String name;
  final String relation;
  final String phone;
  final String email;
  final String aadhaarNumber;
  final String dob;

  FamilyDetails({
    required this.id,
    required this.isHead,
    required this.memberId,
    required this.name,
    required this.relation,
    required this.phone,
    required this.email,
    required this.aadhaarNumber,
    required this.dob,
  });

  factory FamilyDetails.fromJson(Map<String, dynamic> json) {
    return FamilyDetails(
      id: json['id'],
      isHead: json['is_head'] == 1,
      memberId: json['member_id'],
      name: json['name'],
      relation: json['relation'],
      phone: json['phone'],
      email: json['email'],
      aadhaarNumber: json['adhaar_number'],
      dob: json['dob'],
    );
  }
}

// help_received.dart
class HelpReceived {
  final int id;
  final int memberId;
  final int memberFamilyId;
  final String helpType;
  final String incidentDate;
  final String creditedDate;
  final String creditedAmount;
  final String familyMemberName;

  HelpReceived({
    required this.id,
    required this.memberId,
    required this.memberFamilyId,
    required this.helpType,
    required this.incidentDate,
    required this.creditedDate,
    required this.creditedAmount,
    required this.familyMemberName,
  });

  factory HelpReceived.fromJson(Map<String, dynamic> json) {
    return HelpReceived(
      id: json['id'],
      memberId: json['member_id'],
      memberFamilyId: json['member_family_id'],
      helpType: json['help_type'],
      incidentDate: json['incident_date'],
      creditedDate: json['credited_date'],
      creditedAmount: json['credited_amount'],
      familyMemberName: json['family_member_name'],
    );
  }
}
