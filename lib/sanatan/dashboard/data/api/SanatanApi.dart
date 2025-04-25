import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'SanatanApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class SanatanApi {
  factory SanatanApi(Dio dio) = _SanatanApi;

  @POST('/sanatanweb/v1/createPost')
  Future<HttpResponse> createSanatanPost(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getPostList')
  Future<HttpResponse> getSanatanPost(@Header('authorization') String token);
}
