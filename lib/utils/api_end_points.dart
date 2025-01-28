// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiEndPoints {
  ApiEndPoints._();
  static const String BASE_URL = 'http://16.171.239.118/';
  static String LOGIN_URI = 'login';
  static String SIGNUP_URI = 'signup';
  static String FORGOTPASSWOTRD_URI = 'forgotpassword';
  static String VERIFYOTP_URI = 'verify-otp';
  static String RESETPASSWORD_URI = 'reset-password';

  ///audio data
  static String ALL_AUDIO = 'get-audios';
  static String CREATE_AUDIO = 'create-audio';
}
