class LogUpModel {
  String? clientKey;
  String? deviceType;
  String? email;
  String? password;

  LogUpModel({this.clientKey, this.deviceType, this.email, this.password});

  LogUpModel.fromJson(Map<String, dynamic> json) {
    clientKey = json['client_key'];
    deviceType = json['device_type'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_key'] = clientKey;
    data['device_type'] = deviceType;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
