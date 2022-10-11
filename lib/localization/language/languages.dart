import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  /// ************ App labels ************///
  String get appName;

  /// ************ Common labels ************///
  String get error;

  String get success;

  String get sent;

  String get successSent;

  String get submit;

  String get labelSelectLanguage;

  String get labelSignOut;

  String get labelContinue;

  String get wentWrong;

  /// ************ Landing labels ************///
  String get swiper1Title;

  String get swiper1SubTitle;

  String get swiper1Desc;

  String get swiper2Title;

  String get swiper2SubTitle;

  String get swiper2Desc;

  String get swiper3Title;

  String get swiper3SubTitle;

  String get swiper3Desc;

  String get swiper4Title;

  String get swiper4SubTitle;

  String get swiper4Desc;

  /// ************ Login labels ************///

  String get labelSignIn;

  String get labelEmail;

  String get labelPassword;

  String get labelForgotPassword;

  String get labelRememberMe;

  String get labelLogin;

  String get labelNoAccount;

  String get labelRegisterNow;

  String get labelEnterLoginDetails;

  String get labelUserName;

  /// ************ Forgot pass labels ************///
  String get labelForgot;

  String get labelFPassword;

  String get labelFMessage;

  /// ************ Registration labels ************///
  String get labelRegister;

  String get registerSuccess;

  String get labelAlreadyHaveAcc;

  String get labelLoginNow;

  String get labelRepeatPass;

  String get labelRegistrationConfirmMsg;

  String get labelTermsConditions;

  String get labelPrivacyPolicy;

  /// ************ OTP ************///
  String get labelMobileNumber;

  String get labelEnterOTP;

  String get labelMobileCodeSent;

  String get labelChange;

  String get labelResend;

  /// ************ validation messages ************///

  String get validPhone;

  String get emptyUser;

  String get emptyPassword;

  String get emptyEmail;

  String get passwordMismatch;

  String get emptyAddress;

  /// ************ Contact details ************///
  String get contactDetails;

  String get labelContactName;

  String get labelContactPhone;

  String get labelContactAddress;

  /// ************ Calendar labels ************///

  String get monthLabel;
  String get weekLabel;

  /// ************ Settings labels ************///
  String get reviewRatingLabel;
  String get serviceSetupLabel;
  String get scheduleManagementLabel;
  String get businessDetailsLabel;
  String get bookingSettingsLabel;
  String get personalSettingsLabel;

  /// ************ Client Screens labels ************///

  String get clientsLabel;
  String get clientAppointmentsLabel;
  String get newClientLabel;
  String get editClientLabel;
  String get clientDetailsLabel;
  String get appointmentsLabel;
  String get cancellationLabel;
  String get noShowLabel;
  String get birthdayLabel;
  String get lastVisitLabel;
  String get discountLabel;
  String get totalRevenueLabel;
  String get trustedClientLabel;
  String get notesLabel;
  String get showAllLabel;
  String get fullNameLabel;
  String get phoneNumberLabel;
  String get emailAddressLabel;
  String get addressLabel;
  String get permissionsLabel;
  String get isTrustedClientLabel;
  String get trustedClientModalBody;
  String get flashMessageSuccessTitle;
  String get flashMessageErrorTitle;
  String get clientCreatedWronglyBody;
  String get clientUpdatedSuccessfullyBody;
  String get clientCreatedSuccessfullyBody;
  String get notSetLabel;
  String get yesLabel;
  String get noLabel;

  String get emptyAppointmentListLabel;
  String get addNewAppointmentLabel;
}
