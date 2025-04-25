import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';
part 'WallpaperApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class WallpaperApi {
  factory WallpaperApi(Dio dio) = _WallpaperApi;

  @POST('/sanatanweb/v1/creatWallPaper')
  Future<HttpResponse> createWallpaper(
      @Header('authorization') String token, @Body() Map<String, dynamic> data);

  @GET('/sanatanweb/v1/getWallPaper')
  Future<HttpResponse> getWallPaper(@Header('authorization') String token);
}
