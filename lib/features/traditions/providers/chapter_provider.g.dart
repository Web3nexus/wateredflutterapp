// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chapterHash() => r'b12f1755c233d5044d76da94f70d116549b8b6d6';

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

/// Provider for a single chapter by ID
///
/// Copied from [chapter].
@ProviderFor(chapter)
const chapterProvider = ChapterFamily();

/// Provider for a single chapter by ID
///
/// Copied from [chapter].
class ChapterFamily extends Family<AsyncValue<Chapter>> {
  /// Provider for a single chapter by ID
  ///
  /// Copied from [chapter].
  const ChapterFamily();

  /// Provider for a single chapter by ID
  ///
  /// Copied from [chapter].
  ChapterProvider call(int id) {
    return ChapterProvider(id);
  }

  @override
  ChapterProvider getProviderOverride(covariant ChapterProvider provider) {
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
  String? get name => r'chapterProvider';
}

/// Provider for a single chapter by ID
///
/// Copied from [chapter].
class ChapterProvider extends AutoDisposeFutureProvider<Chapter> {
  /// Provider for a single chapter by ID
  ///
  /// Copied from [chapter].
  ChapterProvider(int id)
    : this._internal(
        (ref) => chapter(ref as ChapterRef, id),
        from: chapterProvider,
        name: r'chapterProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chapterHash,
        dependencies: ChapterFamily._dependencies,
        allTransitiveDependencies: ChapterFamily._allTransitiveDependencies,
        id: id,
      );

  ChapterProvider._internal(
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
    FutureOr<Chapter> Function(ChapterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChapterProvider._internal(
        (ref) => create(ref as ChapterRef),
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
  AutoDisposeFutureProviderElement<Chapter> createElement() {
    return _ChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterProvider && other.id == id;
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
mixin ChapterRef on AutoDisposeFutureProviderRef<Chapter> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ChapterProviderElement extends AutoDisposeFutureProviderElement<Chapter>
    with ChapterRef {
  _ChapterProviderElement(super.provider);

  @override
  int get id => (origin as ChapterProvider).id;
}

String _$chapterListHash() => r'f7880f03a2b1baf72ec458fd89fe1dbfceb2e6d2';

abstract class _$ChapterList
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<Chapter>> {
  late final int collectionId;
  late final int page;
  late final int perPage;

  FutureOr<PaginatedResponse<Chapter>> build({
    required int collectionId,
    int page = 1,
    int perPage = 50,
  });
}

/// Provider for chapters by collection
///
/// Copied from [ChapterList].
@ProviderFor(ChapterList)
const chapterListProvider = ChapterListFamily();

/// Provider for chapters by collection
///
/// Copied from [ChapterList].
class ChapterListFamily extends Family<AsyncValue<PaginatedResponse<Chapter>>> {
  /// Provider for chapters by collection
  ///
  /// Copied from [ChapterList].
  const ChapterListFamily();

  /// Provider for chapters by collection
  ///
  /// Copied from [ChapterList].
  ChapterListProvider call({
    required int collectionId,
    int page = 1,
    int perPage = 50,
  }) {
    return ChapterListProvider(
      collectionId: collectionId,
      page: page,
      perPage: perPage,
    );
  }

  @override
  ChapterListProvider getProviderOverride(
    covariant ChapterListProvider provider,
  ) {
    return call(
      collectionId: provider.collectionId,
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
  String? get name => r'chapterListProvider';
}

/// Provider for chapters by collection
///
/// Copied from [ChapterList].
class ChapterListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ChapterList,
          PaginatedResponse<Chapter>
        > {
  /// Provider for chapters by collection
  ///
  /// Copied from [ChapterList].
  ChapterListProvider({
    required int collectionId,
    int page = 1,
    int perPage = 50,
  }) : this._internal(
         () => ChapterList()
           ..collectionId = collectionId
           ..page = page
           ..perPage = perPage,
         from: chapterListProvider,
         name: r'chapterListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$chapterListHash,
         dependencies: ChapterListFamily._dependencies,
         allTransitiveDependencies:
             ChapterListFamily._allTransitiveDependencies,
         collectionId: collectionId,
         page: page,
         perPage: perPage,
       );

  ChapterListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionId,
    required this.page,
    required this.perPage,
  }) : super.internal();

  final int collectionId;
  final int page;
  final int perPage;

  @override
  FutureOr<PaginatedResponse<Chapter>> runNotifierBuild(
    covariant ChapterList notifier,
  ) {
    return notifier.build(
      collectionId: collectionId,
      page: page,
      perPage: perPage,
    );
  }

  @override
  Override overrideWith(ChapterList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChapterListProvider._internal(
        () => create()
          ..collectionId = collectionId
          ..page = page
          ..perPage = perPage,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionId: collectionId,
        page: page,
        perPage: perPage,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ChapterList,
    PaginatedResponse<Chapter>
  >
  createElement() {
    return _ChapterListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterListProvider &&
        other.collectionId == collectionId &&
        other.page == page &&
        other.perPage == perPage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChapterListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<Chapter>> {
  /// The parameter `collectionId` of this provider.
  int get collectionId;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;
}

class _ChapterListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ChapterList,
          PaginatedResponse<Chapter>
        >
    with ChapterListRef {
  _ChapterListProviderElement(super.provider);

  @override
  int get collectionId => (origin as ChapterListProvider).collectionId;
  @override
  int get page => (origin as ChapterListProvider).page;
  @override
  int get perPage => (origin as ChapterListProvider).perPage;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
