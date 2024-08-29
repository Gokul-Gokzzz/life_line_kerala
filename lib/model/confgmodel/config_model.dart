class configmodel {
  bool? status;
  String? message;
  String? companyPhone;
  String? companyName;
  String? companyWebLogo;
  String? companyEmail;
  String? shopAddress;
  String? downloadAppAppleStroe;
  String? downloadAppGoogleStroe;

  configmodel({
    this.status,
    this.message,
    this.companyPhone,
    this.companyName,
    this.companyWebLogo,
    this.companyEmail,
    this.shopAddress,
    this.downloadAppAppleStroe,
    this.downloadAppGoogleStroe,
  });

  configmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    companyPhone = json['company_phone'];
    companyName = json['company_name'];
    companyWebLogo = json['company_web_logo'];
    companyEmail = json['company_email'];
    shopAddress = json['shop_address'];
    downloadAppAppleStroe = json['download_app_apple_stroe'];
    downloadAppGoogleStroe = json['download_app_google_stroe'];
  }

  Map<String, dynamic> toJson(data) {
    data['status'] = status;
    data['message'] = message;
    data['company_phone'] = companyPhone;
    data['company_name'] = companyName;
    data['company_web_logo'] = companyWebLogo;
    data['company_email'] = companyEmail;
    data['shop_address'] = shopAddress;
    data['download_app_apple_stroe'] = downloadAppAppleStroe;
    data['download_app_google_stroe'] = downloadAppGoogleStroe;

    return data;
  }
}
