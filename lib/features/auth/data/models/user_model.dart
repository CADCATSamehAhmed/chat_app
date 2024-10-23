class UserModel {
  late String uid;
  late String name;
  late String email;
  late String phone;
  late String image;

  UserModel(
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.image,
  );

  UserModel.fromJson(Map<String, dynamic>? json, {data}) {
    uid = json!['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
