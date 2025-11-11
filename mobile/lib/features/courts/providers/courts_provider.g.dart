// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbyCourtsHash() => r'900a6bf882f4780bcaec9dd54163ec14c64673f8';

/// See also [nearbyCourts].
@ProviderFor(nearbyCourts)
final nearbyCourtsProvider = AutoDisposeFutureProvider<List<Court>>.internal(
  nearbyCourts,
  name: r'nearbyCourtsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nearbyCourtsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NearbyCourtsRef = AutoDisposeFutureProviderRef<List<Court>>;
String _$courtDetailsHash() => r'cbd12a72d31c3ee4f9fb1fadd4e0c4fff3af8cf8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [courtDetails].
@ProviderFor(courtDetails)
const courtDetailsProvider = CourtDetailsFamily();

/// See also [courtDetails].
class CourtDetailsFamily extends Family<AsyncValue<Court>> {
  /// See also [courtDetails].
  const CourtDetailsFamily();

  /// See also [courtDetails].
  CourtDetailsProvider call(
    String courtId,
  ) {
    return CourtDetailsProvider(
      courtId,
    );
  }

  @override
  CourtDetailsProvider getProviderOverride(
    covariant CourtDetailsProvider provider,
  ) {
    return call(
      provider.courtId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courtDetailsProvider';
}

/// See also [courtDetails].
class CourtDetailsProvider extends AutoDisposeFutureProvider<Court> {
  /// See also [courtDetails].
  CourtDetailsProvider(
    String courtId,
  ) : this._internal(
          (ref) => courtDetails(
            ref as CourtDetailsRef,
            courtId,
          ),
          from: courtDetailsProvider,
          name: r'courtDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courtDetailsHash,
          dependencies: CourtDetailsFamily._dependencies,
          allTransitiveDependencies:
              CourtDetailsFamily._allTransitiveDependencies,
          courtId: courtId,
        );

  CourtDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courtId,
  }) : super.internal();

  final String courtId;

  @override
  Override overrideWith(
    FutureOr<Court> Function(CourtDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourtDetailsProvider._internal(
        (ref) => create(ref as CourtDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courtId: courtId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Court> createElement() {
    return _CourtDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourtDetailsProvider && other.courtId == courtId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courtId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourtDetailsRef on AutoDisposeFutureProviderRef<Court> {
  /// The parameter `courtId` of this provider.
  String get courtId;
}

class _CourtDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Court> with CourtDetailsRef {
  _CourtDetailsProviderElement(super.provider);

  @override
  String get courtId => (origin as CourtDetailsProvider).courtId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
