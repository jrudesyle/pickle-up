// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'court.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Court _$CourtFromJson(Map<String, dynamic> json) {
  return _Court.fromJson(json);
}

/// @nodoc
mixin _$Court {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get surface => throw _privateConstructorUsedError;
  bool get hasLights => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  double? get feeAmount => throw _privateConstructorUsedError;
  String? get feeDescription => throw _privateConstructorUsedError;
  int get courtsCount => throw _privateConstructorUsedError;
  Map<String, dynamic>? get openHours => throw _privateConstructorUsedError;
  List<String>? get amenities => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get websiteUrl => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  int? get activeCheckins => throw _privateConstructorUsedError;
  String? get crowdingLevel => throw _privateConstructorUsedError;

  /// Serializes this Court to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Court
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourtCopyWith<Court> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourtCopyWith<$Res> {
  factory $CourtCopyWith(Court value, $Res Function(Court) then) =
      _$CourtCopyWithImpl<$Res, Court>;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      double latitude,
      double longitude,
      String type,
      String? surface,
      bool hasLights,
      bool isFree,
      double? feeAmount,
      String? feeDescription,
      int courtsCount,
      Map<String, dynamic>? openHours,
      List<String>? amenities,
      String? description,
      String? websiteUrl,
      String? phone,
      bool verified,
      List<String>? photos,
      double? distance,
      int? activeCheckins,
      String? crowdingLevel});
}

/// @nodoc
class _$CourtCopyWithImpl<$Res, $Val extends Court>
    implements $CourtCopyWith<$Res> {
  _$CourtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Court
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? type = null,
    Object? surface = freezed,
    Object? hasLights = null,
    Object? isFree = null,
    Object? feeAmount = freezed,
    Object? feeDescription = freezed,
    Object? courtsCount = null,
    Object? openHours = freezed,
    Object? amenities = freezed,
    Object? description = freezed,
    Object? websiteUrl = freezed,
    Object? phone = freezed,
    Object? verified = null,
    Object? photos = freezed,
    Object? distance = freezed,
    Object? activeCheckins = freezed,
    Object? crowdingLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLights: null == hasLights
          ? _value.hasLights
          : hasLights // ignore: cast_nullable_to_non_nullable
              as bool,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      feeAmount: freezed == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      feeDescription: freezed == feeDescription
          ? _value.feeDescription
          : feeDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      courtsCount: null == courtsCount
          ? _value.courtsCount
          : courtsCount // ignore: cast_nullable_to_non_nullable
              as int,
      openHours: freezed == openHours
          ? _value.openHours
          : openHours // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      amenities: freezed == amenities
          ? _value.amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      activeCheckins: freezed == activeCheckins
          ? _value.activeCheckins
          : activeCheckins // ignore: cast_nullable_to_non_nullable
              as int?,
      crowdingLevel: freezed == crowdingLevel
          ? _value.crowdingLevel
          : crowdingLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourtImplCopyWith<$Res> implements $CourtCopyWith<$Res> {
  factory _$$CourtImplCopyWith(
          _$CourtImpl value, $Res Function(_$CourtImpl) then) =
      __$$CourtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      double latitude,
      double longitude,
      String type,
      String? surface,
      bool hasLights,
      bool isFree,
      double? feeAmount,
      String? feeDescription,
      int courtsCount,
      Map<String, dynamic>? openHours,
      List<String>? amenities,
      String? description,
      String? websiteUrl,
      String? phone,
      bool verified,
      List<String>? photos,
      double? distance,
      int? activeCheckins,
      String? crowdingLevel});
}

/// @nodoc
class __$$CourtImplCopyWithImpl<$Res>
    extends _$CourtCopyWithImpl<$Res, _$CourtImpl>
    implements _$$CourtImplCopyWith<$Res> {
  __$$CourtImplCopyWithImpl(
      _$CourtImpl _value, $Res Function(_$CourtImpl) _then)
      : super(_value, _then);

  /// Create a copy of Court
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? type = null,
    Object? surface = freezed,
    Object? hasLights = null,
    Object? isFree = null,
    Object? feeAmount = freezed,
    Object? feeDescription = freezed,
    Object? courtsCount = null,
    Object? openHours = freezed,
    Object? amenities = freezed,
    Object? description = freezed,
    Object? websiteUrl = freezed,
    Object? phone = freezed,
    Object? verified = null,
    Object? photos = freezed,
    Object? distance = freezed,
    Object? activeCheckins = freezed,
    Object? crowdingLevel = freezed,
  }) {
    return _then(_$CourtImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLights: null == hasLights
          ? _value.hasLights
          : hasLights // ignore: cast_nullable_to_non_nullable
              as bool,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      feeAmount: freezed == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      feeDescription: freezed == feeDescription
          ? _value.feeDescription
          : feeDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      courtsCount: null == courtsCount
          ? _value.courtsCount
          : courtsCount // ignore: cast_nullable_to_non_nullable
              as int,
      openHours: freezed == openHours
          ? _value._openHours
          : openHours // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      amenities: freezed == amenities
          ? _value._amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: freezed == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      activeCheckins: freezed == activeCheckins
          ? _value.activeCheckins
          : activeCheckins // ignore: cast_nullable_to_non_nullable
              as int?,
      crowdingLevel: freezed == crowdingLevel
          ? _value.crowdingLevel
          : crowdingLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourtImpl implements _Court {
  const _$CourtImpl(
      {required this.id,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude,
      this.type = 'OUTDOOR',
      this.surface,
      this.hasLights = false,
      this.isFree = true,
      this.feeAmount,
      this.feeDescription,
      this.courtsCount = 1,
      final Map<String, dynamic>? openHours,
      final List<String>? amenities,
      this.description,
      this.websiteUrl,
      this.phone,
      this.verified = false,
      final List<String>? photos,
      this.distance,
      this.activeCheckins,
      this.crowdingLevel})
      : _openHours = openHours,
        _amenities = amenities,
        _photos = photos;

  factory _$CourtImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourtImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final String type;
  @override
  final String? surface;
  @override
  @JsonKey()
  final bool hasLights;
  @override
  @JsonKey()
  final bool isFree;
  @override
  final double? feeAmount;
  @override
  final String? feeDescription;
  @override
  @JsonKey()
  final int courtsCount;
  final Map<String, dynamic>? _openHours;
  @override
  Map<String, dynamic>? get openHours {
    final value = _openHours;
    if (value == null) return null;
    if (_openHours is EqualUnmodifiableMapView) return _openHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _amenities;
  @override
  List<String>? get amenities {
    final value = _amenities;
    if (value == null) return null;
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? description;
  @override
  final String? websiteUrl;
  @override
  final String? phone;
  @override
  @JsonKey()
  final bool verified;
  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? distance;
  @override
  final int? activeCheckins;
  @override
  final String? crowdingLevel;

  @override
  String toString() {
    return 'Court(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, type: $type, surface: $surface, hasLights: $hasLights, isFree: $isFree, feeAmount: $feeAmount, feeDescription: $feeDescription, courtsCount: $courtsCount, openHours: $openHours, amenities: $amenities, description: $description, websiteUrl: $websiteUrl, phone: $phone, verified: $verified, photos: $photos, distance: $distance, activeCheckins: $activeCheckins, crowdingLevel: $crowdingLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.hasLights, hasLights) ||
                other.hasLights == hasLights) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.feeAmount, feeAmount) ||
                other.feeAmount == feeAmount) &&
            (identical(other.feeDescription, feeDescription) ||
                other.feeDescription == feeDescription) &&
            (identical(other.courtsCount, courtsCount) ||
                other.courtsCount == courtsCount) &&
            const DeepCollectionEquality()
                .equals(other._openHours, _openHours) &&
            const DeepCollectionEquality()
                .equals(other._amenities, _amenities) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.activeCheckins, activeCheckins) ||
                other.activeCheckins == activeCheckins) &&
            (identical(other.crowdingLevel, crowdingLevel) ||
                other.crowdingLevel == crowdingLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        address,
        latitude,
        longitude,
        type,
        surface,
        hasLights,
        isFree,
        feeAmount,
        feeDescription,
        courtsCount,
        const DeepCollectionEquality().hash(_openHours),
        const DeepCollectionEquality().hash(_amenities),
        description,
        websiteUrl,
        phone,
        verified,
        const DeepCollectionEquality().hash(_photos),
        distance,
        activeCheckins,
        crowdingLevel
      ]);

  /// Create a copy of Court
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourtImplCopyWith<_$CourtImpl> get copyWith =>
      __$$CourtImplCopyWithImpl<_$CourtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourtImplToJson(
      this,
    );
  }
}

abstract class _Court implements Court {
  const factory _Court(
      {required final String id,
      required final String name,
      required final String address,
      required final double latitude,
      required final double longitude,
      final String type,
      final String? surface,
      final bool hasLights,
      final bool isFree,
      final double? feeAmount,
      final String? feeDescription,
      final int courtsCount,
      final Map<String, dynamic>? openHours,
      final List<String>? amenities,
      final String? description,
      final String? websiteUrl,
      final String? phone,
      final bool verified,
      final List<String>? photos,
      final double? distance,
      final int? activeCheckins,
      final String? crowdingLevel}) = _$CourtImpl;

  factory _Court.fromJson(Map<String, dynamic> json) = _$CourtImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get type;
  @override
  String? get surface;
  @override
  bool get hasLights;
  @override
  bool get isFree;
  @override
  double? get feeAmount;
  @override
  String? get feeDescription;
  @override
  int get courtsCount;
  @override
  Map<String, dynamic>? get openHours;
  @override
  List<String>? get amenities;
  @override
  String? get description;
  @override
  String? get websiteUrl;
  @override
  String? get phone;
  @override
  bool get verified;
  @override
  List<String>? get photos;
  @override
  double? get distance;
  @override
  int? get activeCheckins;
  @override
  String? get crowdingLevel;

  /// Create a copy of Court
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourtImplCopyWith<_$CourtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
