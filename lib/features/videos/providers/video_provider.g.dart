// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$villageVideoHash() => r'1f94dc8a2a85125a4eacb49ddeb95115ea3dfff0';

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

/// See also [villageVideo].
@ProviderFor(villageVideo)
const villageVideoProvider = VillageVideoFamily();

/// See also [villageVideo].
class VillageVideoFamily extends Family<AsyncValue<Video>> {
  /// See also [villageVideo].
  const VillageVideoFamily();

  /// See also [villageVideo].
  VillageVideoProvider call(int id) {
    return VillageVideoProvider(id);
  }

  @override
  VillageVideoProvider getProviderOverride(
    covariant VillageVideoProvider provider,
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
  String? get name => r'villageVideoProvider';
}

/// See also [villageVideo].
class VillageVideoProvider extends AutoDisposeFutureProvider<Video> {
  /// See also [villageVideo].
  VillageVideoProvider(int id)
    : this._internal(
        (ref) => villageVideo(ref as VillageVideoRef, id),
        from: villageVideoProvider,
        name: r'villageVideoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$villageVideoHash,
        dependencies: VillageVideoFamily._dependencies,
        allTransitiveDependencies:
            VillageVideoFamily._allTransitiveDependencies,
        id: id,
      );

  VillageVideoProvider._internal(
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
    FutureOr<Video> Function(VillageVideoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VillageVideoProvider._internal(
        (ref) => create(ref as VillageVideoRef),
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
  AutoDisposeFutureProviderElement<Video> createElement() {
    return _VillageVideoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VillageVideoProvider && other.id == id;
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
mixin VillageVideoRef on AutoDisposeFutureProviderRef<Video> {
  /// The parameter `id` of this provider.
  int get id;
}

class _VillageVideoProviderElement
    extends AutoDisposeFutureProviderElement<Video>
    with VillageVideoRef {
  _VillageVideoProviderElement(super.provider);

  @override
  int get id => (origin as VillageVideoProvider).id;
}

String _$videoListHash() => r'8e94b6f4c9e074d0b0f91b3a5d899848b6242f1a';

abstract class _$VideoList
    extends BuildlessAutoDisposeAsyncNotifier<PaginatedResponse<Video>> {
  late final int page;
  late final int perPage;
  late final int? traditionId;
  late final String? search;

  FutureOr<PaginatedResponse<Video>> build({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
  });
}

/// See also [VideoList].
@ProviderFor(VideoList)
const videoListProvider = VideoListFamily();

/// See also [VideoList].
class VideoListFamily extends Family<AsyncValue<PaginatedResponse<Video>>> {
  /// See also [VideoList].
  const VideoListFamily();

  /// See also [VideoList].
  VideoListProvider call({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
  }) {
    return VideoListProvider(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
    );
  }

  @override
  VideoListProvider getProviderOverride(covariant VideoListProvider provider) {
    return call(
      page: provider.page,
      perPage: provider.perPage,
      traditionId: provider.traditionId,
      search: provider.search,
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
  String? get name => r'videoListProvider';
}

/// See also [VideoList].
class VideoListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          VideoList,
          PaginatedResponse<Video>
        > {
  /// See also [VideoList].
  VideoListProvider({
    int page = 1,
    int perPage = 20,
    int? traditionId,
    String? search,
  }) : this._internal(
         () => VideoList()
           ..page = page
           ..perPage = perPage
           ..traditionId = traditionId
           ..search = search,
         from: videoListProvider,
         name: r'videoListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$videoListHash,
         dependencies: VideoListFamily._dependencies,
         allTransitiveDependencies: VideoListFamily._allTransitiveDependencies,
         page: page,
         perPage: perPage,
         traditionId: traditionId,
         search: search,
       );

  VideoListProvider._internal(
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
  }) : super.internal();

  final int page;
  final int perPage;
  final int? traditionId;
  final String? search;

  @override
  FutureOr<PaginatedResponse<Video>> runNotifierBuild(
    covariant VideoList notifier,
  ) {
    return notifier.build(
      page: page,
      perPage: perPage,
      traditionId: traditionId,
      search: search,
    );
  }

  @override
  Override overrideWith(VideoList Function() create) {
    return ProviderOverride(
      origin: this,
      override: VideoListProvider._internal(
        () => create()
          ..page = page
          ..perPage = perPage
          ..traditionId = traditionId
          ..search = search,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        perPage: perPage,
        traditionId: traditionId,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<VideoList, PaginatedResponse<Video>>
  createElement() {
    return _VideoListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoListProvider &&
        other.page == page &&
        other.perPage == perPage &&
        other.traditionId == traditionId &&
        other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, perPage.hashCode);
    hash = _SystemHash.combine(hash, traditionId.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VideoListRef
    on AutoDisposeAsyncNotifierProviderRef<PaginatedResponse<Video>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `perPage` of this provider.
  int get perPage;

  /// The parameter `traditionId` of this provider.
  int? get traditionId;

  /// The parameter `search` of this provider.
  String? get search;
}

class _VideoListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          VideoList,
          PaginatedResponse<Video>
        >
    with VideoListRef {
  _VideoListProviderElement(super.provider);

  @override
  int get page => (origin as VideoListProvider).page;
  @override
  int get perPage => (origin as VideoListProvider).perPage;
  @override
  int? get traditionId => (origin as VideoListProvider).traditionId;
  @override
  String? get search => (origin as VideoListProvider).search;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
