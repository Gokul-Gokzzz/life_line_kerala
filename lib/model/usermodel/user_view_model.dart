import 'package:lifelinekerala/model/usermodel/member_details.dart';

class userViewModel {
  bool? status;
  String? message;
  MemberDetails? memberDetails;
  List? familyDetails;
  List? helpReceived;

  userViewModel(
      {this.status,
      this.message,
      this.memberDetails,
      this.familyDetails,
      this.helpReceived});

  userViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    memberDetails = json['member_details'] != null
        ? MemberDetails.fromJson(json['member_details'])
        : null;
    familyDetails = json['familyDetails'];
    helpReceived = json['helpReceived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

    data['member_details'] = this.memberDetails;

    data['family_details'] = this.familyDetails;

    data['help_received'] = this.helpReceived;

    return data;
  }
}