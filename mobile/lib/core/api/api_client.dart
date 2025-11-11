import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';
import '../models/court.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth endpoints
  @POST('/v1/auth/register')
  Future<Map<String, dynamic>> register(@Body() Map<String, dynamic> body);

  @POST('/v1/auth/login')
  Future<Map<String, dynamic>> login(@Body() Map<String, dynamic> body);

  @GET('/v1/auth/me')
  Future<User> getCurrentUser();

  // Court endpoints
  @GET('/v1/courts')
  Future<List<Court>> getNearbyCourts({
    @Query('lat') required double latitude,
    @Query('lng') required double longitude,
    @Query('radius') double? radius,
  });

  @GET('/v1/courts/{id}')
  Future<Court> getCourtDetails(@Path('id') String id);

  @POST('/v1/courts/{id}/checkins')
  Future<Map<String, dynamic>> checkIn(
    @Path('id') String courtId,
    @Body() Map<String, dynamic> body,
  );

  // Ladder endpoints
  @POST('/v1/ladders')
  Future<Map<String, dynamic>> createLadder(@Body() Map<String, dynamic> body);

  @GET('/v1/ladders/{id}')
  Future<Map<String, dynamic>> getLadderDetails(@Path('id') String id);

  @GET('/v1/ladders/{id}/standings')
  Future<List<Map<String, dynamic>>> getLadderStandings(@Path('id') String id);

  // Match endpoints
  @GET('/v1/matches/{id}')
  Future<Map<String, dynamic>> getMatchDetails(@Path('id') String id);

  @POST('/v1/matches/{id}/result')
  Future<Map<String, dynamic>> submitMatchResult(
    @Path('id') String matchId,
    @Body() Map<String, dynamic> body,
  );

  @PUT('/v1/matches/{id}/confirm')
  Future<Map<String, dynamic>> confirmMatchResult(@Path('id') String matchId);
}
