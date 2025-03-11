import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'AuthApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/login')
  Future<HttpResponse> sendOtp(@Body() Map<String, dynamic> data);

  @POST('/verifyotp')
  Future<HttpResponse> verifyOtp(@Body() Map<String, dynamic> data);
}
