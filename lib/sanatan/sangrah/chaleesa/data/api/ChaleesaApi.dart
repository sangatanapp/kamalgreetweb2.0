import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'ChaleesaApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class ChaleesaApi {
  factory ChaleesaApi(Dio dio) = _ChaleesaApi;

  @POST('/sanatanweb/v1/creatChalisa')
  Future<HttpResponse> createChaleesa(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getChalisa')
  Future<HttpResponse> getChaleesa(@Header('authorization') String token);

  @DELETE('/sanatanweb/v1/deleteChalis/{id}')
  Future<HttpResponse> deleteChaleesa(
      @Header('authorization') String token, @Path('id') int id);
}
