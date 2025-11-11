import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
import '../config/app_config.dart';
import '../models/user.dart';

part 'auth_service.g.dart';

class AuthService {
  final ApiClient _apiClient;
  final FlutterSecureStorage _storage;

  AuthService(this._apiClient, this._storage);

  Future<String?> getToken() async {
    return await _storage.read(key: AppConfig.authTokenKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConfig.authTokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: AppConfig.authTokenKey);
    await _storage.delete(key: AppConfig.userIdKey);
    await _storage.delete(key: AppConfig.userEmailKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final response = await _apiClient.register({
      'email': email,
      'password': password,
      'name': name,
      if (phone != null) 'phone': phone,
    });

    if (response['token'] != null) {
      await saveToken(response['token']);
      if (response['user']?['id'] != null) {
        await _storage.write(
          key: AppConfig.userIdKey,
          value: response['user']['id'],
        );
      }
    }

    return response;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.login({
      'email': email,
      'password': password,
    });

    if (response['token'] != null) {
      await saveToken(response['token']);
      if (response['user']?['id'] != null) {
        await _storage.write(
          key: AppConfig.userIdKey,
          value: response['user']['id'],
        );
      }
      await _storage.write(key: AppConfig.userEmailKey, value: email);
    }

    return response;
  }

  Future<void> logout() async {
    await clearToken();
  }

  Future<User> getCurrentUser() async {
    return await _apiClient.getCurrentUser();
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  const storage = FlutterSecureStorage();
  return AuthService(apiClient, storage);
}

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<User?> build() async {
    final authService = ref.watch(authServiceProvider);
    final isAuth = await authService.isAuthenticated();
    
    if (!isAuth) return null;
    
    try {
      return await authService.getCurrentUser();
    } catch (e) {
      await authService.clearToken();
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.login(email: email, password: password);
      return await authService.getCurrentUser();
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      return await authService.getCurrentUser();
    });
  }

  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    state = const AsyncValue.data(null);
  }
}
