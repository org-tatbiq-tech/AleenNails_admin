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
  String get successSent =>
      "אימיל שחזור סיסמה נשלח בהצלחה!, בבקשה תבדוק את המייל";

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
  String get labelEnterLoginDetails =>
      "Please enter the details below to continue";

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
  String get labelEnterOTP =>
      "Please enter your Mobile number for OTP Authentication";

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
  String get emptyUser => 'שם איש הקשר לא יכול להיות ריק!';

  @override
  String get emptyEmail => 'Email can not be empty';

  @override
  String get emptyPassword => 'Password can not be empty';

  @override
  String get passwordMismatch => 'Passwords mismatch';

  @override
  String get emptyAddress => 'הכתובת לא יכולה להיות ריקה!';

  /// ************ Contact details ************///
  @override
  String get contactDetails => "Contact details";

  @override
  String get labelContactName => "Name";

  @override
  String get labelContactPhone => "Phone";

  @override
  String get labelContactAddress => "Address";

  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "month";
  @override
  String get weekLabel => "week";

  /// ************ Settings labels ************///
  @override
  String get reviewRatingLabel => "Reviews & Ratings";
  @override
  String get serviceSetupLabel => "Services Setup";
  @override
  String get scheduleManagementLabel => "Schedule Management";
  @override
  String get businessDetailsLabel => "Business Details";
  @override
  String get bookingSettingsLabel => "Booking Settings";
  @override
  String get personalSettingsLabel => "Personal Settings";

  /// ************ Client Screens labels ************///

  @override
  String get clientsLabel => "clients";
  @override
  String get clientAppointmentsLabel => "client appointments";
  @override
  String get newClientLabel => "new client";
  @override
  String get editClientLabel => "edit client";
  @override
  String get clientDetailsLabel => "client details";
  @override
  String get appointmentsLabel => "appointments";
  @override
  String get cancellationLabel => "cancellation";
  @override
  String get noShowLabel => "no-show";
  @override
  String get birthdayLabel => "birthday";
  @override
  String get lastVisitLabel => "last visit";
  @override
  String get discountLabel => "discount";
  @override
  String get totalRevenueLabel => "total revenue";
  @override
  String get trustedClientLabel => "trusted client";
  @override
  String get notesLabel => "notes";
  @override
  String get showAllLabel => "show all";
  @override
  String get fullNameLabel => "full name";
  @override
  String get phoneNumberLabel => "phone number";
  @override
  String get emailAddressLabel => "email address";
  @override
  String get addressLabel => "Address";
  @override
  String get permissionsLabel => "permissions";
  @override
  String get isTrustedClientLabel => "is trusted client";
  @override
  String get trustedClientModalBody =>
      "If switched off client will not be able automatically book an appointment.";
  @override
  String get flashMessageSuccessTitle => "well done!";
  @override
  String get flashMessageErrorTitle => "oh snap!";
  @override
  String get clientCreatedWronglyBody =>
      "change a few things up and try submitting again.";
  @override
  String get clientUpdatedSuccessfullyBody =>
      "your client have been updated successfully.";
  @override
  String get clientCreatedSuccessfullyBody =>
      "your client have been created successfully.";
  @override
  String get notSetLabel => "not set";
  @override
  String get yesLabel => "yes";
  @override
  String get noLabel => "no";

  @override
  String get emptyAppointmentListLabel => "no appointment added yet";
  @override
  String get addNewAppointmentLabel => "add new appointment";
}
