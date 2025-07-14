import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'UserDataApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class UserDataApi {
  factory UserDataApi(Dio dio) = _UserDataApi;

  @GET('/api/v3/getIosUserData')
  Future<HttpResponse> getIosUserData(@Header('authorization') String token);
}
