// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectionHash() => r'219c354e80e5f8c8e34f78bf2872a341b6190773';

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

/// Provider for a single collection by ID
///
/// Copied from [collection].
@ProviderFor(collection)
const collectionProvider = CollectionFamily();

/// Provider for a single collection by ID
///
/// Copied from [collection].
class CollectionFamily extends Family<AsyncValue<TextCollection>> {
  /// Provider for a single collection by ID
  ///
  /// Copied from [collection].
  const CollectionFamily();

  /// Provider for a single collection by ID
  ///
  /// Copied from [collection].
  CollectionProvider call(int id) {
    return CollectionProvider(id);
  }

  @override
  CollectionProvider getProviderOverride(
    covariant CollectionProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'collectionProvider';
}

/// Provider for a single collection by ID
///
/// Copied from [collection].
class CollectionProvider extends AutoDisposeFutureProvider<TextCollection> {
  /// Provider for a single collection by ID
  ///
  /// Copied from [collection].
  CollectionProvider(int id)
    : this._internal(
        (ref) => collection(ref as CollectionRef, id),
        from: collectionProvider,
        name: r'collectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$collectionHash,
        dependencies: CollectionFamily._dependencies,
        allTransitiveDependencies: CollectionFamily._allTransitiveDependencies,
        id: id,
      );

  CollectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<TextCollection> Function(CollectionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionProvider._internal(
        (ref) => create(ref as CollectionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TextCollection> createElement() {
    return _CollectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionRef on AutoDisposeFutureProviderRef<TextCollection> {
  /// The parameter `id` of this provider.
  int get id;
}

class _CollectionProviderElement
    extends AutoDisposeFutureProviderElement<TextCollection>
    with CollectionRef {
  _CollectionProviderElement(super.provider);

  @override
  int get id => (origin as CollectionProvider).id;
}

String _$collectionListHash() => r'3bf9040e5fb68295535352e5490c1eb4a56694b3';

abstract class _$CollectionList
    extends
        BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<TextCollection>> {
  late final int traditionId;
  late final String? languageCode;
  late final int page;
  late final int perPage;

  FutureOr<PaginatedResponse<TextCollection>> build({
    required int traditionId,
    String? languageCode,
    int page = 1,
    int perPage = 20,
  });
}

/// Provider for text collections by tradition with language filtering
///
/// Copied from [CollectionList].
@ProviderFor(CollectionList)
const collectionListProvider = CollectionListFamily();

/// Provider for text collections by tradition with language filtering
///
/// Copied from [CollectionList].
class CollectionListFamily
    extends Family<AsyncValue<PaginatedResponse<TextCollection>>> {
  /// Provider for text collections by tradition with language filtering
  ///
  /// Copied from [CollectionList].
  const CollectionListFamily();

  /// Provider for text collections by tradition with language filtering
  ///
  /// Copied from [CollectionList].
  CollectionListProvider call({
    required int traditionId,
    String? languageCode,
    int page = 1,
    int perPage = 20,
  }) {
    return CollectionListProvider(
      traditionId: traditionId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  @override
  CollectionListProvider getProviderOverride(
    covariant CollectionListProvider provider,
  ) {
    return call(
      traditionId: provider.traditionId,
      languageCode: provider.languageCode,
      page: provider.page,
      perPage: provider.perPage,
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
  String? get name => r'collectionListProvider';
}

/// Provider for text collections by tradition with language filtering
///
/// Copied from [CollectionList].
class CollectionListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CollectionList,
          PaginatedResponse<TextCollection>
        > {
  /// Provider for text collections by tradition with language filtering
  ///
  /// Copied from [CollectionList].
  CollectionListProvider({
    required int traditionId,
    String? languageCode,
    int page = 1,
    int perPage = 20,
  }) : this._internal(
         () => CollectionList()
           ..traditionId = traditionId
           ..languageCode = languageCode
           ..page = page
           ..perPage = perPage,
         from: collectionListProvider,
         name: r'collectionListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$collectionListHash,
         dependencies: CollectionListFamily._dependencies,
         allTransitiveDependencies:
             CollectionListFamily._allTransitiveDependencies,
         traditionId: traditionId,
         languageCode: languageCode,
         page: page,
         perPage: perPage,
       );

  CollectionListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.traditionId,
    required this.languageCode,
    required this.page,
    required this.perPage,
  }) : super.internal();

  final int traditionId;
  final String? languageCode;
  final int page;
  final int perPage;

  @override
  FutureOr<PaginatedResponse<TextCollection>> runNotifierBuild(
    covariant CollectionList notifier,
  ) {
    return notifier.build(
      traditionId: traditionId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  @override
  Override overrideWith(CollectionList Function() create) {
    return ProviderOverride(
      origin: this,
      override: CollectionListProvider._internal(
        () => create()
          ..traditionId = traditionId
          ..languageCode = languageCode
          ..page = page
          ..perPage = perPage,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        traditionId: traditionId,
        languageCode: languageCode,
        page: page,
        perPage: perPage,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    CollectionList,
    PaginatedResponse<TextCollection>
  >
  createElement() {
    return _CollectionListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionListProvider &&
        other.traditionId == traditionId &&
        other.languageCode == languageCode &&
        other.page == page &&
        other.perPage == perPage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, traditionId.hashCode);
    hash = _SystemHash.combine(hash, languageCode.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CollectionListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<TextCollection>> {
  /// The parameter `traditionId` of this provider.
  int get traditionId;

  /// The parameter `languageCode` of this provider.
  String? get languageCode;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;
}

class _CollectionListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CollectionList,
          PaginatedResponse<TextCollection>
        >
    with CollectionListRef {
  _CollectionListProviderElement(super.provider);

  @override
  int get traditionId => (origin as CollectionListProvider).traditionId;
  @override
  String? get languageCode => (origin as CollectionListProvider).languageCode;
  @override
  int get page => (origin as CollectionListProvider).page;
  @override
  int get perPage => (origin as CollectionListProvider).perPage;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
