// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      skillLevel: (json['skillLevel'] as num?)?.toDouble(),
      timezone: json['timezone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String? ?? 'PLAYER',
      emailVerified: json['emailVerified'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'skillLevel': instance.skillLevel,
      'timezone': instance.timezone,
      'avatarUrl': instance.avatarUrl,
      'role': instance.role,
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
    };
