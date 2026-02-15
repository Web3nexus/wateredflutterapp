import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/deities/models/deity.dart';
import 'package:Watered/features/deities/services/deity_service.dart';
import 'package:Watered/features/traditions/models/tradition.dart';

// State for selected tradition filter
final selectedTraditionProvider = StateProvider<int?>((ref) => null);

final traditionsListProvider = FutureProvider.autoDispose<List<Tradition>>((ref) async {
  final service = ref.watch(deityServiceProvider);
  return await service.getTraditions();
});

// Search query for deities
final deitySearchQueryProvider = StateProvider<String>((ref) => '');

class PaginatedDeities {
  final List<Deity> items;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  PaginatedDeities({
    required this.items,
    required this.currentPage,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  PaginatedDeities copyWith({
    List<Deity>? items,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginatedDeities(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class DeitiesListNotifier extends AutoDisposeAsyncNotifier<PaginatedDeities> {
  @override
  Future<PaginatedDeities> build() async {
    final service = ref.watch(deityServiceProvider);
    final traditionId = ref.watch(selectedTraditionProvider);
    final search = ref.watch(deitySearchQueryProvider);
    
    final response = await service.getDeities(
      traditionId: traditionId,
      search: search,
      page: 1,
    );

    final List data = response['data'] ?? [];
    final items = data.map((e) => Deity.fromJson(e)).toList();
    final currentPage = response['current_page'] ?? 1;
    final lastPage = response['last_page'] ?? 1;

    return PaginatedDeities(
      items: items,
      currentPage: currentPage,
      hasMore: currentPage < lastPage,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || !currentState.hasMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final service = ref.read(deityServiceProvider);
      final traditionId = ref.read(selectedTraditionProvider);
      final search = ref.read(deitySearchQueryProvider);
      
      final nextPage = currentState.currentPage + 1;
      final response = await service.getDeities(
        traditionId: traditionId,
        search: search,
        page: nextPage,
      );

      final List data = response['data'] ?? [];
      final newItems = data.map((e) => Deity.fromJson(e)).toList();
      final currentPage = response['current_page'] ?? nextPage;
      final lastPage = response['last_page'] ?? nextPage;

      state = AsyncData(currentState.copyWith(
        items: [...currentState.items, ...newItems],
        currentPage: currentPage,
        hasMore: currentPage < lastPage,
        isLoadingMore: false,
      ));
    } catch (e, st) {
      state = AsyncData(currentState.copyWith(isLoadingMore: false));
      // Log error or handle as needed
    }
  }
}

final deitiesListProvider = AsyncNotifierProvider.autoDispose<DeitiesListNotifier, PaginatedDeities>(() {
  return DeitiesListNotifier();
});
