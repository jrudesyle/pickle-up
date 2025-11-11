import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/dio_provider.dart';
import '../../../core/models/court.dart';
import '../../../core/config/app_config.dart';

part 'courts_provider.g.dart';

@riverpod
Future<List<Court>> nearbyCourts(NearbyCourtsRef ref) async {
  final apiClient = ref.watch(apiClientProvider);
  
  // TODO: Get actual user location
  // For now, use Clarion, PA coordinates
  const latitude = 41.2145; // Clarion, PA
  const longitude = -79.3881;
  
  return await apiClient.getNearbyCourts(
    latitude: latitude,
    longitude: longitude,
    radius: AppConfig.nearbyCourtRadius,
  );
}

@riverpod
Future<Court> courtDetails(CourtDetailsRef ref, String courtId) async {
  final apiClient = ref.watch(apiClientProvider);
  return await apiClient.getCourtDetails(courtId);
}
