// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entryHash() => r'4822278513cf01dc83a2d85011f6dc6e04e724e1';

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

/// Provider for a single entry by ID
///
/// Copied from [entry].
@ProviderFor(entry)
const entryProvider = EntryFamily();

/// Provider for a single entry by ID
///
/// Copied from [entry].
class EntryFamily extends Family<AsyncValue<Entry>> {
  /// Provider for a single entry by ID
  ///
  /// Copied from [entry].
  const EntryFamily();

  /// Provider for a single entry by ID
  ///
  /// Copied from [entry].
  EntryProvider call(int id, {String? languageCode}) {
    return EntryProvider(id, languageCode: languageCode);
  }

  @override
  EntryProvider getProviderOverride(covariant EntryProvider provider) {
    return call(provider.id, languageCode: provider.languageCode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'entryProvider';
}

/// Provider for a single entry by ID
///
/// Copied from [entry].
class EntryProvider extends AutoDisposeFutureProvider<Entry> {
  /// Provider for a single entry by ID
  ///
  /// Copied from [entry].
  EntryProvider(int id, {String? languageCode})
    : this._internal(
        (ref) => entry(ref as EntryRef, id, languageCode: languageCode),
        from: entryProvider,
        name: r'entryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$entryHash,
        dependencies: EntryFamily._dependencies,
        allTransitiveDependencies: EntryFamily._allTransitiveDependencies,
        id: id,
        languageCode: languageCode,
      );

  EntryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.languageCode,
  }) : super.internal();

  final int id;
  final String? languageCode;

  @override
  Override overrideWith(FutureOr<Entry> Function(EntryRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: EntryProvider._internal(
        (ref) => create(ref as EntryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        languageCode: languageCode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Entry> createElement() {
    return _EntryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntryProvider &&
        other.id == id &&
        other.languageCode == languageCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, languageCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EntryRef on AutoDisposeFutureProviderRef<Entry> {
  /// The parameter `id` of this provider.
  int get id;

  /// The parameter `languageCode` of this provider.
  String? get languageCode;
}

class _EntryProviderElement extends AutoDisposeFutureProviderElement<Entry>
    with EntryRef {
  _EntryProviderElement(super.provider);

  @override
  int get id => (origin as EntryProvider).id;
  @override
  String? get languageCode => (origin as EntryProvider).languageCode;
}

String _$entryListHash() => r'a5ff3952897b08c5bff7b6793962d224cda9c246';

abstract class _$EntryList
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<Entry>> {
  late final int chapterId;
  late final String? languageCode;
  late final int page;
  late final int perPage;

  FutureOr<PaginatedResponse<Entry>> build({
    required int chapterId,
    String? languageCode,
    int page = 1,
    int perPage = 50,
  });
}

/// Provider for entries by chapter with bookmark hooks
///
/// Copied from [EntryList].
@ProviderFor(EntryList)
const entryListProvider = EntryListFamily();

/// Provider for entries by chapter with bookmark hooks
///
/// Copied from [EntryList].
class EntryListFamily extends Family<AsyncValue<PaginatedResponse<Entry>>> {
  /// Provider for entries by chapter with bookmark hooks
  ///
  /// Copied from [EntryList].
  const EntryListFamily();

  /// Provider for entries by chapter with bookmark hooks
  ///
  /// Copied from [EntryList].
  EntryListProvider call({
    required int chapterId,
    String? languageCode,
    int page = 1,
    int perPage = 50,
  }) {
    return EntryListProvider(
      chapterId: chapterId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  @override
  EntryListProvider getProviderOverride(covariant EntryListProvider provider) {
    return call(
      chapterId: provider.chapterId,
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
  String? get name => r'entryListProvider';
}

/// Provider for entries by chapter with bookmark hooks
///
/// Copied from [EntryList].
class EntryListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          EntryList,
          PaginatedResponse<Entry>
        > {
  /// Provider for entries by chapter with bookmark hooks
  ///
  /// Copied from [EntryList].
  EntryListProvider({
    required int chapterId,
    String? languageCode,
    int page = 1,
    int perPage = 50,
  }) : this._internal(
         () => EntryList()
           ..chapterId = chapterId
           ..languageCode = languageCode
           ..page = page
           ..perPage = perPage,
         from: entryListProvider,
         name: r'entryListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$entryListHash,
         dependencies: EntryListFamily._dependencies,
         allTransitiveDependencies: EntryListFamily._allTransitiveDependencies,
         chapterId: chapterId,
         languageCode: languageCode,
         page: page,
         perPage: perPage,
       );

  EntryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapterId,
    required this.languageCode,
    required this.page,
    required this.perPage,
  }) : super.internal();

  final int chapterId;
  final String? languageCode;
  final int page;
  final int perPage;

  @override
  FutureOr<PaginatedResponse<Entry>> runNotifierBuild(
    covariant EntryList notifier,
  ) {
    return notifier.build(
      chapterId: chapterId,
      languageCode: languageCode,
      page: page,
      perPage: perPage,
    );
  }

  @override
  Override overrideWith(EntryList Function() create) {
    return ProviderOverride(
      origin: this,
      override: EntryListProvider._internal(
        () => create()
          ..chapterId = chapterId
          ..languageCode = languageCode
          ..page = page
          ..perPage = perPage,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapterId: chapterId,
        languageCode: languageCode,
        page: page,
        perPage: perPage,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EntryList, PaginatedResponse<Entry>>
  createElement() {
    return _EntryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntryListProvider &&
        other.chapterId == chapterId &&
        other.languageCode == languageCode &&
        other.page == page &&
        other.perPage == perPage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapterId.hashCode);
    hash = _SystemHash.combine(hash, languageCode.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EntryListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<Entry>> {
  /// The parameter `chapterId` of this provider.
  int get chapterId;

  /// The parameter `languageCode` of this provider.
  String? get languageCode;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;
}

class _EntryListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          EntryList,
          PaginatedResponse<Entry>
        >
    with EntryListRef {
  _EntryListProviderElement(super.provider);

  @override
  int get chapterId => (origin as EntryListProvider).chapterId;
  @override
  String? get languageCode => (origin as EntryListProvider).languageCode;
  @override
  int get page => (origin as EntryListProvider).page;
  @override
  int get perPage => (origin as EntryListProvider).perPage;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
