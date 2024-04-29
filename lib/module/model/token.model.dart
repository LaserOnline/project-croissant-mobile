class GetToken {
  String? accessToken;
  String? refreshToken;

  GetToken({
    this.accessToken,
    this.refreshToken,
  });

  GetToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
