// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiEndPoints {
  ApiEndPoints._();
  static const String BASE_URL = 'http://192.168.18.142:8000/';
  static String SIGNUP_URI = 'signup';
  static String LOGIN_URI = 'login';

  static String FORGOTPASSWOTRD_URI = 'forgotpassword';
  static String VERIFYOTP_URI = 'verify-otp';
  static String RESETPASSWORD_URI = 'reset-password';

  ///audio data
  static String ALL_AUDIO = 'get-audios';
  static String CREATE_AUDIO = 'create-audio';

  //adddriver
  static String ADDDRIVER_URI = 'create-admin';
  static const String ADMIN_NAMES_URI = 'admin-names';
  static const String ADMIN_PROFILE_PICTURE_URI = 'admin';
  static const String ADMIN_DETAILS_URI = 'admin-details';
}
