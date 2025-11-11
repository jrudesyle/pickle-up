// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourtImpl _$$CourtImplFromJson(Map<String, dynamic> json) => _$CourtImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      type: json['type'] as String? ?? 'OUTDOOR',
      surface: json['surface'] as String?,
      hasLights: json['hasLights'] as bool? ?? false,
      isFree: json['isFree'] as bool? ?? true,
      feeAmount: (json['feeAmount'] as num?)?.toDouble(),
      feeDescription: json['feeDescription'] as String?,
      courtsCount: (json['courtsCount'] as num?)?.toInt() ?? 1,
      openHours: json['openHours'] as Map<String, dynamic>?,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      phone: json['phone'] as String?,
      verified: json['verified'] as bool? ?? false,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      distance: (json['distance'] as num?)?.toDouble(),
      activeCheckins: (json['activeCheckins'] as num?)?.toInt(),
      crowdingLevel: json['crowdingLevel'] as String?,
    );

Map<String, dynamic> _$$CourtImplToJson(_$CourtImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'type': instance.type,
      'surface': instance.surface,
      'hasLights': instance.hasLights,
      'isFree': instance.isFree,
      'feeAmount': instance.feeAmount,
      'feeDescription': instance.feeDescription,
      'courtsCount': instance.courtsCount,
      'openHours': instance.openHours,
      'amenities': instance.amenities,
      'description': instance.description,
      'websiteUrl': instance.websiteUrl,
      'phone': instance.phone,
      'verified': instance.verified,
      'photos': instance.photos,
      'distance': instance.distance,
      'activeCheckins': instance.activeCheckins,
      'crowdingLevel': instance.crowdingLevel,
    };
