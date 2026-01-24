import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:Watered/features/events/services/event_service.dart';

final eventsListProvider = FutureProvider.autoDispose<List<Event>>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getEvents();
});

class EventController extends StateNotifier<AsyncValue<void>> {
  final EventService _service;
  final Ref _ref;

  EventController(this._service, this._ref) : super(const AsyncValue.data(null));

  Future<void> registerForEvent(int eventId) async {
    state = const AsyncValue.loading();
    try {
      await _service.registerForEvent(eventId);
      _ref.invalidate(eventsListProvider); // Refresh list to show 'registered' status
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelRegistration(int eventId) async {
    state = const AsyncValue.loading();
    try {
      await _service.cancelRegistration(eventId);
      _ref.invalidate(eventsListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final eventControllerProvider = StateNotifierProvider<EventController, AsyncValue<void>>((ref) {
  return EventController(ref.watch(eventServiceProvider), ref);
});
