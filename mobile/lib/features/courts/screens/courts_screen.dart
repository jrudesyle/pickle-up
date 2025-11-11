import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/court.dart';
import '../providers/courts_provider.dart';

class CourtsScreen extends ConsumerStatefulWidget {
  const CourtsScreen({super.key});

  @override
  ConsumerState<CourtsScreen> createState() => _CourtsScreenState();
}

class _CourtsScreenState extends ConsumerState<CourtsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final courtsAsync = ref.watch(nearbyCourtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PickleUp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outlined),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(nearbyCourtsProvider);
        },
        child: courtsAsync.when(
          data: (courts) => courts.isEmpty
              ? _buildEmptyState()
              : _buildCourtsList(courts),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(error.toString()),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              context.go('/courts');
              break;
            case 1:
              context.go('/ladders');
              break;
            case 2:
              context.go('/profile');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sports_tennis_outlined),
            selectedIcon: Icon(Icons.sports_tennis),
            label: 'Courts',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Ladders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCourtsList(List<Court> courts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildLocationChip(),
          );
        }
        
        final court = courts[index - 1];
        return _buildCourtCard(court);
      },
    );
  }

  Widget _buildLocationChip() {
    return Chip(
      avatar: const Icon(Icons.location_on, size: 18),
      label: const Text('Near Clarion, PA'),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Widget _buildCourtCard(Court court) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.go('/courts/${court.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Court name
              Row(
                children: [
                  const Icon(Icons.sports_tennis, color: Color(0xFF4CAF50)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      court.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (court.verified)
                    const Icon(Icons.verified, color: Colors.blue, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              
              // Distance and court count
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${court.distance?.toStringAsFixed(1) ?? '?'} mi',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.grid_view, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${court.courtsCount} ${court.courtsCount == 1 ? 'court' : 'courts'}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Active players and crowding
              if (court.activeCheckins != null && court.activeCheckins! > 0)
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${court.activeCheckins} active',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    _buildCrowdingChip(court.crowdingLevel ?? 'unknown'),
                  ],
                ),
              
              // Amenities
              if (court.amenities != null && court.amenities!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (court.hasLights)
                        const Chip(
                          label: Text('Lights', style: TextStyle(fontSize: 12)),
                          visualDensity: VisualDensity.compact,
                        ),
                      if (court.isFree)
                        const Chip(
                          label: Text('Free', style: TextStyle(fontSize: 12)),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCrowdingChip(String level) {
    Color color;
    IconData icon;
    
    switch (level.toLowerCase()) {
      case 'low':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'medium':
        color = Colors.orange;
        icon = Icons.warning;
        break;
      case 'high':
        color = Colors.red;
        icon = Icons.error;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          level,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_tennis_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No courts found nearby',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your location or search radius',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.invalidate(nearbyCourtsProvider),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
