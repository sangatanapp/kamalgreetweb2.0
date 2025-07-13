import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'AartiApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class AartiApi {
  factory AartiApi(Dio dio) = _AartiApi;

  @POST('/sanatanweb/v1/creatAarti')
  Future<HttpResponse> createAarti(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getAarti')
  Future<HttpResponse> getAarti(@Header('authorization') String token);

  @DELETE('/sanatanweb/v1/deleteArti/{id}')
  Future<HttpResponse> deleteAarti(
      @Header('authorization') String token, @Path('id') int id);
}
