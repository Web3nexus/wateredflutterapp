import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/temples/providers/temple_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class TempleScreen extends ConsumerWidget {
  const TempleScreen({super.key});

  Future<void> _launchMaps(double lat, double lng) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, fetching all temples. Use nearbyTemplesProvider if implemented with Geolocator later.
    final templesState = ref.watch(templeListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('TEMPLE DISCOVERY'),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: templesState.when(
        data: (temples) {
          if (temples.isEmpty) {
            return const Center(
              child: Text(
                'No temples found.',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: temples.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final temple = temples[index];
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: temple.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: temple.imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: const Color(0xFF1E293B),
                                      highlightColor: const Color(0xFF0F172A),
                                      child: Container(color: Colors.white),
                                    ),
                              )
                            : Container(
                                color: Colors.white10,
                                child: const Center(
                                  child: Icon(
                                    Icons.place_outlined,
                                    size: 50,
                                    color: Colors.white24,
                                  ),
                                ),
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
                              Text(
                                temple.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cinzel',
                                ),
                              ),
                              if (temple.latitude != null &&
                                  temple.longitude != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.map_outlined,
                                    color: Color(0xFFD4AF37),
                                  ),
                                  onPressed: () => _launchMaps(
                                    temple.latitude!,
                                    temple.longitude!,
                                  ),
                                ),
                            ],
                          ),
                          if (temple.address != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: Colors.white54,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      temple.address!,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (temple.description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                temple.description!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
        ),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
