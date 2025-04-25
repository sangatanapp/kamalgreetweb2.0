import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'PoojaApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class PoojaApi {
  factory PoojaApi(Dio dio) = _PoojaApi;

  @GET('/sanatanweb/v1/getPoojaList')
  Future<HttpResponse> getPooja(@Header('authorization') String token,
      @Header('language') String language);

  @GET('/sanatanweb/v1/getPoojaPackage')
  Future<HttpResponse> getPoojaPricing(@Header('authorization') String token,
      @Header('language') String language);

  @GET('/sanatanweb/v1/getBookingList')
  Future<HttpResponse> getPoojaBookingList(
      @Header('authorization') String token,
      @Header('language') String language);

  @POST('/sanatanweb/v1/creatPooja')
  Future<HttpResponse> createPooja(@Header('authorization') String token,
      @Header('language') String language, @Body() Map<String, dynamic> data);

  @DELETE('/sanatanweb/v1/deletePooja/{id}')
  Future<HttpResponse> deletePooja(
      @Header('authorization') String token, @Path('id') int id);
}
