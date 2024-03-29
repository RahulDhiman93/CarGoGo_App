class AppStrings {
  static const String helloNiceToMeetYou = 'Hello, nice to meet you';
  static const String login = 'Login';
  static const String register = 'Register';
  static const String getMovingWithCarGoGo = 'Get moving with CarGoGo';
  static const String enterMobileNumber = 'Enter your mobile number';
  static const String enterFirstName = 'Enter your first name';
  static const String enterLastName = 'Enter your last name';
  static const String enterEmail = 'Enter your email';
  static const String enterPassword = 'Enter your password';
  static const String byCreating = 'By creating an account, you agree to our';
  static const String byLogin = 'By login your account, you agree to our';
  static const String termsOfService = 'Terms of Service';
  static const String of = 'of';
  static const String privacyPolicy = 'Privacy Policy';
  static const String phoneVerification = 'Phone Verification';
  static const String enterOtp = 'Enter your OTP code below';
  static const String resendCode = 'Resend code in';
  static const String seconds = 'seconds';
  static const String goodMorning = 'Good Morning';
  static const String whereAreYouGoing = 'Where are you going?';
  static const String from = 'From';
  static const String to = 'To';
}

class AppConstants {
  //static const String baseUrl = 'http://10.0.2.2:8080'; //ANDROID LOCAL
  static const String baseUrl = 'http://127.0.0.1:8080'; //IOS LOCAL
}

class AppApiEndPoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String accessToken = '/auth/accessTokenLogin';
}