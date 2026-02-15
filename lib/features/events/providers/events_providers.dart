import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:Watered/features/events/services/event_service.dart';

class EventFilter {
  final String? category;
  final String? recurrence;
  final int? traditionId;

  const EventFilter({
    this.category,
    this.recurrence,
    this.traditionId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventFilter &&
        other.category == category &&
        other.recurrence == recurrence &&
        other.traditionId == traditionId;
  }

  @override
  int get hashCode => Object.hash(category, recurrence, traditionId);
}

final eventsListProvider = FutureProvider.autoDispose.family<List<Event>, EventFilter>((ref, filter) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getEvents(
    category: filter.category,
    recurrence: filter.recurrence,
    traditionId: filter.traditionId,
  );
});

class EventController extends StateNotifier<AsyncValue<void>> {
  final EventService _service;
  final Ref _ref;

  EventController(this._service, this._ref) : super(const AsyncValue.data(null));

  Future<void> registerForEvent(int eventId) async {
    state = const AsyncValue.loading();
    try {
      await _service.registerForEvent(eventId);
      _ref.invalidate(eventsListProvider); // This will invalidate all families, which is fine
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

  Future<void> toggleReminder(int eventId, bool currentStatus) async {
    state = const AsyncValue.loading();
    try {
      if (currentStatus) {
        await _service.removeReminder(eventId);
      } else {
        await _service.saveReminder(eventId);
      }
      _ref.invalidate(eventsListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Map<String, dynamic>?> initiateEventPayment(int eventId) async {
    state = const AsyncValue.loading();
    try {
      final data = await _service.initiatePayment(eventId);
      state = const AsyncValue.data(null);
      return data;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}

final eventControllerProvider = StateNotifierProvider<EventController, AsyncValue<void>>((ref) {
  return EventController(ref.watch(eventServiceProvider), ref);
});
