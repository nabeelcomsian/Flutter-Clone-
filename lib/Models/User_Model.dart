class UserModel {
  final String userName;
  final String bio;
  final String email;

  final List followers;
  final List following;
  final String uid;
  UserModel(
      {required this.userName,
      required this.bio,
      required this.email,
      required this.followers,
      required this.following,
      required this.uid});

  Map<String, dynamic> toJason() {
    return {
      'name': userName,
      "email": email,
      'uid': uid,
      'bio': bio,
      'folowers': followers,
      'following': following
    };
  }
}
