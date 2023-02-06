class UserModel {
  String? imeiNo;
  String? phoneNumber;
  String? manufacturer;
  String? deviceModelName;
  String? fcmToken;
  String? orderID;
  String? accountID;
  String? availableData;

  UserModel(
      {this.imeiNo,
      this.deviceModelName,
      this.manufacturer,
      this.fcmToken,
      this.orderID,
      this.phoneNumber,
      this.accountID,
      this.availableData});
}
