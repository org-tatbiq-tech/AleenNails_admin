import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

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
  String get emptyEmail;
  String get emptyPassword;
  String get passwordMismatch;
  String get emptyAddress;

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

  /// ************ Client labels ************///
  String get clientLabel;
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

  /// ************ Business Info Labels ************///
  String get businessLabel;
  String get businessNameLabel;
  String get socialMediaLabel;
  String get facebookLabel;
  String get instagramLabel;
  String get websiteLabel;
  String get wazeLabel;
  String get businessDescriptionLabel;
  String get businessDescriptionHint;
  String get businessNameInfoLabel;
  String get logoLabel;
  String get logoDescription;
  String get coverPhotoLabel;
  String get coverPhotoDescription;
  String get workplacePhotoLabel;
  String get workplacePhotoDescription;
  String get profileImagesLabel;
  String get profileImageDescription;
  String get editLogoLabel;
  String get deleteLogoLabel;
  String get addLogoLabel;
  String get addCoverPhotoLabel;
  String get editCoverPhotoLabel;
  String get deleteCoverPhotoLabel;
  String get deletePhotoLabel;

  /// ************ Appointment Labels ************///
  String get emptyAppointmentListLabel;
  String get emptyAppointmentTimeListLabel;
  String get addNewAppointmentLabel;
  String get newAppointmentLabel;
  String get editAppointmentLabel;
  String get appointmentDetailsLabel;
  String get chooseServiceLabel;
  String get walkInClientLabel;
  String get totalLabel;
  String get todayLabel;
  String get bookAgainLabel;
  String get checkoutLabel;
  String get cancelThisAppointmentLabel;
  String get addServiceLabel;

  /// ************ Schedule Management Labels ************///
  String get workingDaysLabel;
  String get unavailabilityLabel;
  String get unavailabilityDeleteLabel;
  String get unavailabilityListLabel;
  String get businessHoursNotesLabel;
  String get businessHoursNotesHint;
  String get breakLabel;
  String get breaksLabel;
  String get addBreakLabel;
  String get workingOnThisDayLabel;
  String get dayDetailsDescriptionLabel;
  String get startDateTimeLabel;
  String get reasonLabel;
  String get reasonHint;

  /// ************ Service Labels ************///
  String get serviceLabel;
  String get servicesLabel;
  String get newServiceLabel;
  String get editServiceLabel;
  String get serviceNameLabel;
  String get priceLabel;
  String get durationLabel;
  String get colorLabel;
  String get descriptionLabel;
  String get deleteServiceLabel;
  String get deleteThisServiceLabel;
  String get messageToClientLabel;
  String get messageToClientModalBody;
  String get clientBookPermissionLabel;
  String get clientBookPermissionModalBody;

  /// ************ Common Labels ************///
  String get notSetLabel;
  String get yesLabel;
  String get noLabel;
  String get submitLabel;
  String get signOutLabel;
  String get continueLabel;
  String get deleteLabel;
  String get backLabel;
  String get actionUndoneLabel;
  String get mediaLabel;
  String get addMediaLabel;
  String get closeLabel;
  String get openLabel;
  String get closedLabel;
  String get startLabel;
  String get startTimeLabel;
  String get endTimeLabel;
  String get confirmLabel;
  String get endLabel;
  String get cancelLabel;
  String get takePhotoLabel;
  String get chooseFromLibraryLabel;
  String get idLabel;
  String get waitingLabel;
  String get confirmedLabel;
  String get cancelledLabel;
  String get declinedLabel;
  String get paidLabel;
  String get unpaidLabel;
  String get saveLabel;
  String get okLabel;

  /// ************ Flash Messages ************///
  String get flashMessageSuccessTitle;
  String get flashMessageErrorTitle;
  String get clientCreatedWronglyBody;
  String get clientUpdatedSuccessfullyBody;
  String get clientCreatedSuccessfullyBody;
  String get wpPhotoDeletedSuccessfullyBody;
  String get wpPhotoUploadedSuccessfullyBody;
  String get logoPhotoDeletedSuccessfullyBody;
  String get covePhotoPhotoDeletedSuccessfullyBody;
  String get logoPhotoUploadedSuccessfullyBody;
  String get coverPhotoPhotoUploadedSuccessfullyBody;
  String get serviceUpdatedSuccessfullyBody;
  String get serviceCreatedSuccessfullyBody;
  String get appointmentUpdatedSuccessfullyBody;
  String get appointmentCreatedSuccessfullyBody;
  String get appointmentCancelledSuccessfullyBody;
  String get clientMissingBody;
  String get serviceMissingBody;
  String get adminMissingBody;
  String get adminMissingTitle;
  String get infoUpdatedSuccessfullyBody;
  String get workingDayUpdatedSuccessfullyBody;
  String get unavailabilityUpdatedSuccessfullyBody;
  String get unavailabilityDeletedSuccessfullyBody;

  /// ************ Languages ************///
  String get labelEnglish;
  String get labelHebrew;
  String get labelArabic;
}
