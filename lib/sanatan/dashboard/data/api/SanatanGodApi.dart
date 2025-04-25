import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'SanatanGodApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class SanatanGodApi {
  factory SanatanGodApi(Dio dio) = _SanatanGodApi;

  @POST('/sanatanweb/v1/createGodList')
  Future<HttpResponse> createGod(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getGodList')
  Future<HttpResponse> getGodList(@Header('authorization') String token);
}
