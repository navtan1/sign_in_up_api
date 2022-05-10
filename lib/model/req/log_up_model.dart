class Log_Up_Model {
  String? clientKey;
  String? deviceType;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? dob;
  String? password;
  String? confirmPassword;

  Log_Up_Model(
      {this.clientKey,
      this.deviceType,
      this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.dob,
      this.password,
      this.confirmPassword});

  Log_Up_Model.fromJson(Map<String, dynamic> json) {
    clientKey = json['client_key'];
    deviceType = json['device_type'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_key'] = clientKey;
    data['device_type'] = deviceType;
    data['fname'] = fname;
    data['lname'] = lname;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dob'] = dob;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
