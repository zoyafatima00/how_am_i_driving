import 'package:dio/dio.dart';

import '../../../../helpers/pref_init.dart';
import '../../../../utils/shared_prefs_keys.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await MyPrefs.getStringShared(SharedPrefsKeys.TOKEN);

    if (token == null || token.contains('null')) {
      options.headers = {'Content-Type': 'application/json'};
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
      }
    } else {}

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
