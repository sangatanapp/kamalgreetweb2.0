import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'AccessApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class AccessApi {
  factory AccessApi(Dio dio) = _AccessApi;

  @POST('/api/v2/resetUser')
  Future<HttpResponse> resetUser(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @POST('/api/v2/enableSubscription')
  Future<HttpResponse> enableSubscription(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @POST('/api/v2/getDisputeData')
  Future<HttpResponse> getDisputeData(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);
}
