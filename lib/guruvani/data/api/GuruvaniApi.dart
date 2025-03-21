import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'GuruvaniApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class GuruvaniApi {
  factory GuruvaniApi(Dio dio) = _GuruvaniApi;

  @GET('/guruvani/v1/getWebGuruCardList')
  Future<HttpResponse> getGuruvaniCardList(
      @Header('authorization') String token,
      @Header('language') String language);

  @POST('/guruvani/v1/createGuru')
  Future<HttpResponse> createGuru(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @PUT('/guruvani/v1/updateGuru')
  Future<HttpResponse> updateGuru(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/guruvani/v1/getGuruList')
  Future<HttpResponse> getGuruList(@Header('authorization') String token);

  @DELETE('/guruvani/v1/deleteGuru/{id}')
  Future<HttpResponse> deleteGuru(
      @Header('authorization') String token, @Path('id') int id);
}
