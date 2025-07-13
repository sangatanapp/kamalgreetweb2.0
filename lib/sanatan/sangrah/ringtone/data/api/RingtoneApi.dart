import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'RingtoneApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class RingtoneApi {
  factory RingtoneApi(Dio dio) = _RingtoneApi;

  @POST('/sanatanweb/v1/creatRingtone')
  Future<HttpResponse> createRingtone(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getRingtonList')
  Future<HttpResponse> getRingtone(@Header('authorization') String token);

  @DELETE('/sanatanweb/v1/deleteRingtonList/{id}')
  Future<HttpResponse> deleteRingtone(
      @Header('authorization') String token, @Path('id') int id);
}
