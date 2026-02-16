// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioCategoriesHash() => r'7cdb9cfee3d9d2c7ac2013dbbf0536d91ba79b5e';

/// See also [audioCategories].
@ProviderFor(audioCategories)
final audioCategoriesProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
      audioCategories,
      name: r'audioCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$audioCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AudioCategoriesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$audioDetailHash() => r'e0ddbf4de5b49d05aa171dfe46c4788c3916add2';

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

/// See also [audioDetail].
@ProviderFor(audioDetail)
const audioDetailProvider = AudioDetailFamily();

/// See also [audioDetail].
class AudioDetailFamily extends Family<AsyncValue<Audio>> {
  /// See also [audioDetail].
  const AudioDetailFamily();

  /// See also [audioDetail].
  AudioDetailProvider call(int id) {
    return AudioDetailProvider(id);
  }

  @override
  AudioDetailProvider getProviderOverride(
    covariant AudioDetailProvider provider,
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
  String? get name => r'audioDetailProvider';
}

/// See also [audioDetail].
class AudioDetailProvider extends AutoDisposeFutureProvider<Audio> {
  /// See also [audioDetail].
  AudioDetailProvider(int id)
    : this._internal(
        (ref) => audioDetail(ref as AudioDetailRef, id),
        from: audioDetailProvider,
        name: r'audioDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$audioDetailHash,
        dependencies: AudioDetailFamily._dependencies,
        allTransitiveDependencies: AudioDetailFamily._allTransitiveDependencies,
        id: id,
      );

  AudioDetailProvider._internal(
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
    FutureOr<Audio> Function(AudioDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AudioDetailProvider._internal(
        (ref) => create(ref as AudioDetailRef),
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
  AutoDisposeFutureProviderElement<Audio> createElement() {
    return _AudioDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioDetailProvider && other.id == id;
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
mixin AudioDetailRef on AutoDisposeFutureProviderRef<Audio> {
  /// The parameter `id` of this provider.
  int get id;
}

class _AudioDetailProviderElement
    extends AutoDisposeFutureProviderElement<Audio>
    with AudioDetailRef {
  _AudioDetailProviderElement(super.provider);

  @override
  int get id => (origin as AudioDetailProvider).id;
}

String _$audioListHash() => r'e525f81be8acd2cc1cb1004bd9377027f56c7e89';

abstract class _$AudioList
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<Audio>> {
  late final int page;
  late final int perPage;
  late final int? traditionId;
  late final String? search;
  late final String? category;

  FutureOr<PaginatedResponse<Audio>> build({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
    String? category,
  });
}

/// See also [AudioList].
@ProviderFor(AudioList)
const audioListProvider = AudioListFamily();

/// See also [AudioList].
class AudioListFamily extends Family<AsyncValue<PaginatedResponse<Audio>>> {
  /// See also [AudioList].
  const AudioListFamily();

  /// See also [AudioList].
  AudioListProvider call({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
    String? category,
  }) {
    return AudioListProvider(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
      category: category,
    );
  }

  @override
  AudioListProvider getProviderOverride(covariant AudioListProvider provider) {
    return call(
      page: provider.page,
      perPage: provider.perPage,
      traditionId: provider.traditionId,
      search: provider.search,
      category: provider.category,
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
  String? get name => r'audioListProvider';
}

/// See also [AudioList].
class AudioListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AudioList,
          PaginatedResponse<Audio>
        > {
  /// See also [AudioList].
  AudioListProvider({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
    String? category,
  }) : this._internal(
         () => AudioList()
           ..page = page
           ..perPage = perPage
           ..traditionId = traditionId
           ..search = search
           ..category = category,
         from: audioListProvider,
         name: r'audioListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$audioListHash,
         dependencies: AudioListFamily._dependencies,
         allTransitiveDependencies: AudioListFamily._allTransitiveDependencies,
         page: page,
         perPage: perPage,
         traditionId: traditionId,
         search: search,
         category: category,
       );

  AudioListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.perPage,
    required this.traditionId,
    required this.search,
    required this.category,
  }) : super.internal();

  final int page;
  final int perPage;
  final int? traditionId;
  final String? search;
  final String? category;

  @override
  FutureOr<PaginatedResponse<Audio>> runNotifierBuild(
    covariant AudioList notifier,
  ) {
    return notifier.build(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
      category: category,
    );
  }

  @override
  Override overrideWith(AudioList Function() create) {
    return ProviderOverride(
      origin: this,
      override: AudioListProvider._internal(
        () => create()
          ..page = page
          ..perPage = perPage
          ..traditionId = traditionId
          ..search = search
          ..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        perPage: perPage,
        traditionId: traditionId,
        search: search,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AudioList, PaginatedResponse<Audio>>
  createElement() {
    return _AudioListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioListProvider &&
        other.page == page &&
        other.perPage == perPage &&
        other.traditionId == traditionId &&
        other.search == search &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);
    hash = _SystemHash.combine(hash, traditionId.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AudioListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<Audio>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;

  /// The parameter `traditionId` of this provider.
  int? get traditionId;

  /// The parameter `search` of this provider.
  String? get search;

  /// The parameter `category` of this provider.
  String? get category;
}

class _AudioListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AudioList,
          PaginatedResponse<Audio>
        >
    with AudioListRef {
  _AudioListProviderElement(super.provider);

  @override
  int get page => (origin as AudioListProvider).page;
  @override
  int get perPage => (origin as AudioListProvider).perPage;
  @override
  int? get traditionId => (origin as AudioListProvider).traditionId;
  @override
  String? get search => (origin as AudioListProvider).search;
  @override
  String? get category => (origin as AudioListProvider).category;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
