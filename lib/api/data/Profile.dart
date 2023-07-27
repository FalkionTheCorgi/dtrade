class Profile {
  String status;
  List<ProfileData> profile;

  Profile({required this.status, required this.profile});

  factory Profile.fromJson(Map<String, dynamic> json) {
    var dataList = json['profile'] as List<dynamic>;
    List<ProfileData> profileDataList = dataList
        .map((data) => ProfileData.fromJson(data as List<dynamic>))
        .toList();

    return Profile(status: json['status'] as String, profile: profileDataList);
  }
}

class ProfileData {
  int id;
  String uuid;
  String battletag;
  String email;

  ProfileData({
    required this.id,
    required this.uuid,
    required this.battletag,
    required this.email,
  });

  factory ProfileData.fromJson(List<dynamic> json) {
    return ProfileData(
      id: json[0] as int,
      uuid: json[1] as String,
      battletag: json[2] as String,
      email: json[3] as String,
    );
  }
}
