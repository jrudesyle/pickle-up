import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    String? phone,
    double? skillLevel,
    String? timezone,
    String? avatarUrl,
    @Default('PLAYER') String role,
    @Default(false) bool emailVerified,
    @Default(false) bool phoneVerified,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
