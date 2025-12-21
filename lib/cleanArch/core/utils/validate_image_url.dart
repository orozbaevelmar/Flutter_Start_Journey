import 'package:dio/dio.dart';
import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';

class ImageUrlValidation {
  static Future<bool> isValidateCompanyLogoUrl(
    String companyId, {
    Dio? dio,
  }) async {
    try {
      final dioClient = dio ?? Dio();
      final response = await dioClient.head(
        "${getIt<AppFlavorConfig>().apiBaseUrl}accounts/$companyId/logo",
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 400,
        ),
      );
      final contentType = response.headers.value('content-type');
      return response.statusCode == 200 &&
          contentType != null &&
          contentType.startsWith('image/');
    } catch (e) {
      return false;
    }
  }
}
