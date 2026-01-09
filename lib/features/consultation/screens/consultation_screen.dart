import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/consultation/providers/booking_provider.dart';
import 'package:wateredflutterapp/features/consultation/models/consultation_type.dart';
import 'package:wateredflutterapp/features/consultation/screens/booking_form_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ConsultationScreen extends ConsumerWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typesState = ref.watch(consultationTypesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('SPIRITUAL CONSULTATION'),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: typesState.when(
        data: (types) {
          if (types.isEmpty) {
            return const Center(child: Text('No consultation types available.', style: TextStyle(color: Colors.white54)));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: types.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final type = types[index];
              return _ConsultationCard(type: type);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final ConsultationType type;
  const _ConsultationCard({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (type.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: type.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        type.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cinzel',
                        ),
                      ),
                    ),
                    Text(
                      '\$${(type.price / 100).toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text('${type.durationMinutes} mins', style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
                if (type.description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    type.description!,
                    style: const TextStyle(color: Colors.white70, height: 1.4),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => BookingFormScreen(type: type)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('BOOK NOW'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
