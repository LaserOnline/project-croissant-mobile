class UserInfo {
  String username;
  String email;
  String profile;
  List<Map<String, String>> device;
  List<Map<String, String>> friend;

  UserInfo({
    required this.username,
    required this.email,
    required this.profile,
    required this.device,
    required this.friend,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      username: json['username'],
      email: json['email'],
      profile: json['profile'],
      device: List<Map<String, String>>.from(
          json['device'].map((item) => Map<String, String>.from(item))),
      friend: List<Map<String, String>>.from(
          json['friend'].map((item) => Map<String, String>.from(item))),
    );
  }
}
