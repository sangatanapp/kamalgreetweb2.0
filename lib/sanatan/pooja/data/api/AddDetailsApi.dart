import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'AddDetailsApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class AddDetailsApi {
  factory AddDetailsApi(Dio dio) = _AddDetailsApi;

  @POST('/sanatanweb/v1/{remainingPath}')
  Future<HttpResponse> updatePoojaDetails(
      @Path('remainingPath') String remainingPath,
      @Header('authorization') String token,
      @Header('language') String language,
      @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/{remainingPath}/{id}')
  Future<HttpResponse> getPoojaDetails(
      @Path('remainingPath') String remainingPath,
      @Path('id') int poojaId,
      @Header('authorization') String token,
      @Header('language') String language);
}
