// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiEndPoints {
  ApiEndPoints._();
  static const String BASE_URL = 'http://192.168.18.67:8000/';
  static String SIGNUP_URI = 'signup';
  static String LOGIN_URI = 'login';

  static String FORGOTPASSWOTRD_URI = 'forgotpassword';
  static String VERIFYOTP_URI = 'verify-otp';
  static String RESETPASSWORD_URI = 'reset-password';

  ///audio data
  static String ALL_AUDIO = 'get-audios';
  static String CREATE_AUDIO = 'create-audio';

  //addd river
  static String ADDDRIVER_URI = 'create-admin';
  static const String ADMIN_NAMES_URI = 'admin-names';
  static const String ADMIN_PROFILE_PICTURE_URI = 'admin';
  static const String ADMIN_DETAILS_URI = 'admin-details';

  //vehicle
  static String ADD_VEHICLE_URI = 'create-vehicle';
  static const String VEHICLE_NAMES_URI = 'vehicle-names';
  static const String VEHICLE_PROFILE_PICTURE_URI = 'vehicle image';
  static const String VEHICLE_DETAILS_URI = 'vehicle-details';

  //ride
  static String ADD_RIDE_URI = 'add-ride';
  static const String RIDE_LIST_URI = 'ride-list';
  static const String RIDE_DETAILS_URI = 'ride-details';
}
