import 'package:dio/dio.dart';
import 'package:kamal_greet_web_2/Utils/values/AppStrings.dart';
import 'package:retrofit/retrofit.dart';

part 'PaymentApi.g.dart';

@RestApi(baseUrl: AppStrings.kamalBaseUrl)
abstract class PaymentApi {
  factory PaymentApi(Dio dio) = _PaymentApi;

  @POST('/api/v2/updatePaymentMethod')
  Future<HttpResponse> updatePayment(@Header('authorization') String token,
      @Body() Map<String, dynamic> data, @Header('language') String language);

  @GET('/api/v2/getPaymentMethod')
  Future<HttpResponse> getPayment(@Header('authorization') String token);
}
