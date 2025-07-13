import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'MantraApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class MantraApi {
  factory MantraApi(Dio dio) = _MantraApi;

  @POST('/sanatanweb/v1/creatMantra')
  Future<HttpResponse> createMantra(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getMantra')
  Future<HttpResponse> getMantra(@Header('authorization') String token);

  @DELETE('/sanatanweb/v1/deleteMantra/{id}')
  Future<HttpResponse> deleteMantra(
      @Header('authorization') String token, @Path('id') int id);
}
