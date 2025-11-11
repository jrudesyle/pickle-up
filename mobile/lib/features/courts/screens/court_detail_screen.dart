import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/courts_provider.dart';

class CourtDetailScreen extends ConsumerWidget {
  final String courtId;

  const CourtDetailScreen({super.key, required this.courtId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courtAsync = ref.watch(courtDetailsProvider(courtId));

    return Scaffold(
      body: courtAsync.when(
        data: (court) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(court.name),
                background: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(
                    Icons.sports_tennis,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address
                    _buildInfoRow(
                      Icons.location_on_outlined,
                      court.address,
                    ),
                    const SizedBox(height: 12),
                    
                    // Court details
                    _buildInfoRow(
                      Icons.grid_view,
                      '${court.courtsCount} ${court.type.toLowerCase()} ${court.courtsCount == 1 ? 'court' : 'courts'}',
                    ),
                    if (court.surface != null) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.texture, court.surface!),
                    ],
                    const SizedBox(height: 12),
                    
                    // Amenities
                    Row(
                      children: [
                        if (court.hasLights)
                          const Chip(
                            avatar: Icon(Icons.lightbulb_outline, size: 18),
                            label: Text('Lights'),
                          ),
                        const SizedBox(width: 8),
                        Chip(
                          avatar: Icon(
                            court.isFree ? Icons.check_circle : Icons.attach_money,
                            size: 18,
                          ),
                          label: Text(court.isFree ? 'Free' : '\$${court.feeAmount}'),
                        ),
                      ],
                    ),
                    
                    // Description
                    if (court.description != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(court.description!),
                    ],
                    
                    // Active players
                    if (court.activeCheckins != null && court.activeCheckins! > 0) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Currently Active (${court.activeCheckins})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Check in to see who\'s playing!'),
                    ],
                    
                    const SizedBox(height: 32),
                    
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement check-in
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Check-in feature coming soon!')),
                              );
                            },
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text('Check In'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Open maps
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Directions feature coming soon!')),
                              );
                            },
                            icon: const Icon(Icons.directions),
                            label: const Text('Directions'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading court details'),
              const SizedBox(height: 8),
              Text(error.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
