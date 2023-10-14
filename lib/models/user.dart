class User {
  final int id;
  final String username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String profileImage;
  final String? phoneNumber;
  final String? bio;
  final int? followerCount;
  final int? followingCount;
  final int? characterCount;
  final int? imageCount;
  bool isFollowed;

  User(
      {required this.id,
      required this.username,
      this.email,
      this.firstName,
      this.lastName,
      required this.profileImage,
      this.phoneNumber,
      this.bio,
      this.followerCount,
      this.followingCount,
      this.characterCount,
      this.imageCount,
      this.isFollowed = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      bio: json['bio'] ?? '',
      followerCount: json['follower_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      characterCount: json['character_count'] ?? 0,
      imageCount: json['image_count'] ?? 0,
      isFollowed: json['is_followed'] ?? false,
    );
  }
}
