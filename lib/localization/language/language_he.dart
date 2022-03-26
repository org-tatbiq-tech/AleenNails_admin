import 'languages.dart';

class LanguageHe extends Languages {
  /// ************ App labels ************///
  @override
  String get appName => "Studios";

  /// ************ Common labels ************///
  @override
  String get error => "שגיאה";

  @override
  String get success => "הצלחה";

  @override
  String get sent => "נשלח";

  @override
  String get successSent => "אימיל שחזור סיסמה נשלח בהצלחה!, בבקשה תבדוק את המייל";

  @override
  String get submit => "שלח!";

  @override
  String get labelSelectLanguage => "בחר שפה";

  @override
  String get labelSignOut => "התנתק";

  @override
  String get labelContinue => "Continue";

  @override
  String get wentWrong => "Something went wrong!";

  /// ************ Landing labels ************///
  @override
  String get swiper1Title => "This is a Title";

  @override
  String get swiper1SubTitle => "This is a sub Title";

  @override
  String get swiper1Desc => "This is a desc";

  @override
  String get swiper2Title => "This is a Title";

  @override
  String get swiper2SubTitle => "This is a sub Title";

  @override
  String get swiper2Desc => "This is a desc";

  @override
  String get swiper3Title => "This is a Title";

  @override
  String get swiper3SubTitle => "This is a sub Title";

  @override
  String get swiper3Desc => "This is a desc";

  @override
  String get swiper4Title => "This is a Title";

  @override
  String get swiper4SubTitle => "This is a sub Title";

  @override
  String get swiper4Desc => "This is a desc";

  /// ************ Login labels ************///
  @override
  String get labelSignIn => "התחבר";

  @override
  String get labelEmail => "אימייל";

  @override
  String get labelPassword => "סיסמה";

  @override
  String get labelForgotPassword => "שכחת סיסמה?";

  @override
  String get labelRememberMe => "תזכור אותי";

  @override
  String get labelLogin => "תתחבר";

  @override
  String get labelNoAccount => "עוד לא נרשמת? ";

  @override
  String get labelRegisterNow => "הירשם עכשיו!";

  @override
  String get labelEnterLoginDetails => "Please enter the details below to continue";

  @override
  String get labelUserName => "User name";

  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "שכחת";

  @override
  String get labelFPassword => "סיסמה؟";

  @override
  String get labelFMessage => "אל תדאג!\nבבקשה תכניס האימייל שלך";

  /// ************ Registration labels ************///
  @override
  String get labelRegister => "הרשמה";

  @override
  String get registerSuccess => "ברוך הבא!! נרשמת בהצלחה!";

  @override
  String get labelAlreadyHaveAcc => "כבר יש לך חשבון? ";

  @override
  String get labelLoginNow => "תתחבר!";

  @override
  String get labelRepeatPass => "חזור על הסיסמה";

  @override
  String get labelRegistrationConfirmMsg => "By register you are agree to our";

  @override
  String get labelTermsConditions => "Terms & Conditions";

  @override
  String get labelPrivacyPolicy => "Privacy policy";

  /// ************ OTP ************///
  @override
  String get labelMobileNumber => 'Mobile number';

  @override
  String get labelEnterOTP => "Please enter your Mobile number for OTP Authentication";

  @override
  String get labelMobileCodeSent => "בדוק את הטלפון שלך, קוד האימות נשלח";

  @override
  String get labelChange => "שינוי";

  @override
  String get labelResend => "שלח שוב";

  /// ************ validation messages ************///
  @override
  String get validPhone => 'נא להזין מספר טלפון חוקי!';

  @override
  String get emptyContact => 'שם איש הקשר לא יכול להיות ריק!';

  @override
  String get emptyAddress => 'הכתובת לא יכולה להיות ריקה!';
}