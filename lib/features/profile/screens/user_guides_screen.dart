import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/profile/providers/informational_provider.dart';
import 'package:Watered/features/profile/models/informational.dart';
import 'package:url_launcher/url_launcher.dart';

class UserGuidesScreen extends ConsumerWidget {
  const UserGuidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guidesAsync = ref.watch(userGuidesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('USER GUIDES')),
      body: guidesAsync.when(
        data: (guides) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: guides.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final guide = guides[index];
            return _GuideCard(guide: guide);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Failed to load guides: $err')),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final UserGuide guide;
  const _GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (guide.type == 'video' ? Colors.redAccent : const Color(0xFFD4AF37)).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            guide.type == 'video' ? Icons.play_circle_fill_rounded : Icons.menu_book_rounded,
            color: guide.type == 'video' ? Colors.redAccent : const Color(0xFFD4AF37),
          ),
        ),
        title: Text(
          guide.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: (guide.content != null && guide.content!.isNotEmpty)
            ? Text(
                guide.content!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.white24),
        onTap: () async {
          if (guide.type == 'video' && guide.videoUrl != null) {
            final url = Uri.parse(guide.videoUrl!);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          } else {
             // For text guides, we could navigate to a detail screen
             // Simplified: just show a dialog for now or TODO
             showDialog(
               context: context,
               builder: (_) => AlertDialog(
                 backgroundColor: const Color(0xFF0F172A),
                 title: Text(guide.title),
                 content: SingleChildScrollView(child: Text(guide.content ?? '')),
                 actions: [
                   TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE')),
                 ],
               ),
             );
          }
        },
      ),
    );
  }
}

