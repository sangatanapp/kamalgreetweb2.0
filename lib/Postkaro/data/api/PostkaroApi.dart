import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'PostkaroApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class PostkaroApi {
  factory PostkaroApi(Dio dio) = _PostkaroApi;

  @POST('/api/v2/createCard')
  Future<HttpResponse> createPost(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @POST('/createTagList')
  Future<HttpResponse> createTag(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @GET('/api/v2/getTagList?category={category}')
  Future<HttpResponse> getTagList(@Header('authorization') String token,
      @Header('language') String language, @Path('category') String category);

  @PUT('/updateCard/{id}')
  Future<HttpResponse> updateCard(@Header('authorization') String token,
      @Path('id') String id, @Body() Map<String, dynamic> data);

  @POST('/postkarovideo/v1/createVideoCard')
  Future<HttpResponse> createVideoCard(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @GET('/api/v3/getPartyList')
  Future<HttpResponse> getWebPartyList(@Header('authorization') String token,
      @Header('language') String language);

  @POST('/api/v3/createPartyList')
  Future<HttpResponse> createParty(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @PUT('/api/v3/updatePartyList')
  Future<HttpResponse> updatePartyList(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @DELETE('/api/v3/deletePartyList/{id}')
  Future<HttpResponse> deleteParty(@Header('authorization') String token,
      @Path('id') int id, @Header('language') String language);

  @GET('/api/v3/getStateByParty')
  Future<HttpResponse> getStateByParty(@Header('authorization') String token,
      @Header('language') String language, @Query('partyId') int partyId);

  @GET('/api/v2/stateList')
  Future<HttpResponse> getStateList(@Header('authorization') String token,
      @Header('language') String language);
}
