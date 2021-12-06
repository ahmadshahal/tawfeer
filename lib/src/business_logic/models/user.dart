class User {
  late int id;
  late String fullName;
  late String email;
  late String phoneNumber;
  late String imgUrl;

  User({required this.id, required this.fullName, required this.email, required this.phoneNumber, required this.imgUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    imgUrl = json['imgUrl'];
  }
}