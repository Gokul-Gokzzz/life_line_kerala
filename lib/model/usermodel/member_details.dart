class MemberDetails {
  int? id;
  int? districtId;
  String? districtName;
  String? lifelineId;
  String? name;
  String? username;
  String? password;
  String? mobile;
  String? email;
  String? upiId;
  String? accountNumber;
  String? ifscCode;
  String? image;
  String? signature;
  String? dateOfBirth;
  String? place;
  String? address;
  String? otherDocumentDetails;
  String? aadhaarNumber;
  int? accountAmount;
  int? status;
  int? terms;
  String? createdAt;
  String? updatedAt;
  String? rememberToken;
  String? cmFirebaseToken;
  String? temporaryToken;
  List<Null>? translations;

  MemberDetails(
      {this.id,
      this.districtId,
      this.districtName,
      this.lifelineId,
      this.name,
      this.username,
      this.password,
      this.mobile,
      this.email,
      this.upiId,
      this.accountNumber,
      this.ifscCode,
      this.image,
      this.signature,
      this.dateOfBirth,
      this.place,
      this.address,
      this.otherDocumentDetails,
      this.aadhaarNumber,
      this.accountAmount,
      this.status,
      this.terms,
      this.createdAt,
      this.updatedAt,
      this.rememberToken,
      this.cmFirebaseToken,
      this.temporaryToken,
      this.translations});

  MemberDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    lifelineId = json['lifeline_id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    mobile = json['mobile'];
    email = json['email'];
    upiId = json['upi_id'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    image = json['image'];
    signature = json['signature'];
    dateOfBirth = json['date_of_birth'];
    place = json['place'];
    address = json['address'];
    otherDocumentDetails = json['other_document_details'];
    aadhaarNumber = json['aadhaar_number'];
    accountAmount = json['account_amount'];
    status = json['status'];
    terms = json['terms'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rememberToken = json['remember_token'];
    cmFirebaseToken = json['cm_firebase_token'];
    temporaryToken = json['temporary_token'];

    json['translations'] = translations;
  }

  Map<String, dynamic> toJson(data) {
    data['id'] = id;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['lifeline_id'] = lifelineId;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['mobile'] = mobile;
    data['email'] = email;
    data['upi_id'] = upiId;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['image'] = image;
    data['signature'] = signature;
    data['date_of_birth'] = dateOfBirth;
    data['place'] = place;
    data['address'] = address;
    data['other_document_details'] = otherDocumentDetails;
    data['aadhaar_number'] = aadhaarNumber;
    data['account_amount'] = accountAmount;
    data['status'] = status;
    data['terms'] = terms;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['remember_token'] = rememberToken;
    data['cm_firebase_token'] = cmFirebaseToken;
    data['temporary_token'] = temporaryToken;

    data['translations'] = translations;

    return data;
  }
}
