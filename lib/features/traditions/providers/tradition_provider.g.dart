// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradition_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$traditionHash() => r'e42fd4eab5255d7451c7d48b8f476c7af3411137';

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

/// Provider for a single tradition by ID
///
/// Copied from [tradition].
@ProviderFor(tradition)
const traditionProvider = TraditionFamily();

/// Provider for a single tradition by ID
///
/// Copied from [tradition].
class TraditionFamily extends Family<AsyncValue<Tradition>> {
  /// Provider for a single tradition by ID
  ///
  /// Copied from [tradition].
  const TraditionFamily();

  /// Provider for a single tradition by ID
  ///
  /// Copied from [tradition].
  TraditionProvider call(int id) {
    return TraditionProvider(id);
  }

  @override
  TraditionProvider getProviderOverride(covariant TraditionProvider provider) {
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
  String? get name => r'traditionProvider';
}

/// Provider for a single tradition by ID
///
/// Copied from [tradition].
class TraditionProvider extends AutoDisposeFutureProvider<Tradition> {
  /// Provider for a single tradition by ID
  ///
  /// Copied from [tradition].
  TraditionProvider(int id)
    : this._internal(
        (ref) => tradition(ref as TraditionRef, id),
        from: traditionProvider,
        name: r'traditionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$traditionHash,
        dependencies: TraditionFamily._dependencies,
        allTransitiveDependencies: TraditionFamily._allTransitiveDependencies,
        id: id,
      );

  TraditionProvider._internal(
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
    FutureOr<Tradition> Function(TraditionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TraditionProvider._internal(
        (ref) => create(ref as TraditionRef),
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
  AutoDisposeFutureProviderElement<Tradition> createElement() {
    return _TraditionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TraditionProvider && other.id == id;
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
mixin TraditionRef on AutoDisposeFutureProviderRef<Tradition> {
  /// The parameter `id` of this provider.
  int get id;
}

class _TraditionProviderElement
    extends AutoDisposeFutureProviderElement<Tradition>
    with TraditionRef {
  _TraditionProviderElement(super.provider);

  @override
  int get id => (origin as TraditionProvider).id;
}

String _$traditionListHash() => r'fba2f758d2006aee6b76f1b0053c17d4e50c0764';

abstract class _$TraditionList
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<Tradition>> {
  late final int page;
  late final int perPage;

  FutureOr<PaginatedResponse<Tradition>> build({
    int page = 1,
    int perPage = 20,
  });
}

/// Provider for traditions list with pagination
///
/// Copied from [TraditionList].
@ProviderFor(TraditionList)
const traditionListProvider = TraditionListFamily();

/// Provider for traditions list with pagination
///
/// Copied from [TraditionList].
class TraditionListFamily
    extends Family<AsyncValue<PaginatedResponse<Tradition>>> {
  /// Provider for traditions list with pagination
  ///
  /// Copied from [TraditionList].
  const TraditionListFamily();

  /// Provider for traditions list with pagination
  ///
  /// Copied from [TraditionList].
  TraditionListProvider call({int page = 1, int perPage = 20}) {
    return TraditionListProvider(page: page, perPage: perPage);
  }

  @override
  TraditionListProvider getProviderOverride(
    covariant TraditionListProvider provider,
  ) {
    return call(page: provider.page, perPage: provider.perPage);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'traditionListProvider';
}

/// Provider for traditions list with pagination
///
/// Copied from [TraditionList].
class TraditionListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          TraditionList,
          PaginatedResponse<Tradition>
        > {
  /// Provider for traditions list with pagination
  ///
  /// Copied from [TraditionList].
  TraditionListProvider({int page = 1, int perPage = 20})
    : this._internal(
        () => TraditionList()
          ..page = page
          ..perPage = perPage,
        from: traditionListProvider,
        name: r'traditionListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$traditionListHash,
        dependencies: TraditionListFamily._dependencies,
        allTransitiveDependencies:
            TraditionListFamily._allTransitiveDependencies,
        page: page,
        perPage: perPage,
      );

  TraditionListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.perPage,
  }) : super.internal();

  final int page;
  final int perPage;

  @override
  FutureOr<PaginatedResponse<Tradition>> runNotifierBuild(
    covariant TraditionList notifier,
  ) {
    return notifier.build(page: page, perPage: perPage);
  }

  @override
  Override overrideWith(TraditionList Function() create) {
    return ProviderOverride(
      origin: this,
      override: TraditionListProvider._internal(
        () => create()
          ..page = page
          ..perPage = perPage,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        perPage: perPage,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    TraditionList,
    PaginatedResponse<Tradition>
  >
  createElement() {
    return _TraditionListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TraditionListProvider &&
        other.page == page &&
        other.perPage == perPage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TraditionListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<Tradition>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;
}

class _TraditionListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          TraditionList,
          PaginatedResponse<Tradition>
        >
    with TraditionListRef {
  _TraditionListProviderElement(super.provider);

  @override
  int get page => (origin as TraditionListProvider).page;
  @override
  int get perPage => (origin as TraditionListProvider).perPage;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
