import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'StotraApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class StotraApi {
  factory StotraApi(Dio dio) = _StotraApi;

  @POST('/sanatanweb/v1/creatStotra')
  Future<HttpResponse> createStotra(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getStotra')
  Future<HttpResponse> getStotra(@Header('authorization') String token);

  @DELETE('/sanatanweb/v1/deleteStotra/{id}')
  Future<HttpResponse> deleteStotra(
      @Header('authorization') String token, @Path('id') int id);
}
