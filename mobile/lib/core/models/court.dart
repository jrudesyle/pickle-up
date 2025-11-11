import 'package:freezed_annotation/freezed_annotation.dart';

part 'court.freezed.dart';
part 'court.g.dart';

@freezed
class Court with _$Court {
  const factory Court({
    required String id,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    @Default('OUTDOOR') String type,
    String? surface,
    @Default(false) bool hasLights,
    @Default(true) bool isFree,
    double? feeAmount,
    String? feeDescription,
    @Default(1) int courtsCount,
    Map<String, dynamic>? openHours,
    List<String>? amenities,
    String? description,
    String? websiteUrl,
    String? phone,
    @Default(false) bool verified,
    List<String>? photos,
    double? distance,
    int? activeCheckins,
    String? crowdingLevel,
  }) = _Court;

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
}
