import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'DarshanApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class DarshanApi {
  factory DarshanApi(Dio dio) = _DarshanApi;

  @POST('/sanatanweb/v1/creatDarshan')
  Future<HttpResponse> createDarshan(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getDarshan')
  Future<HttpResponse> getDarshan(@Header('authorization') String token);
}
