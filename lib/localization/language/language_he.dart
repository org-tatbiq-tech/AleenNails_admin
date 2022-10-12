import 'languages.dart';

class LanguageHe extends Languages {
  /// ************ App labels ************///
  @override
  String get appName => "Aleen Nails";

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
  String get labelRememberMe => "זכור אותי";

  @override
  String get labelLogin => "התחבר";

  @override
  String get labelNoAccount => "אין לך חשבות?";

  @override
  String get labelRegisterNow => "הירשם עכשיו!";

  @override
  String get labelEnterLoginDetails => "אנא הזן את הפרטים למטה כדי להמשיך";

  @override
  String get labelUserName => "שם משתמם";

  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "שכחת";

  @override
  String get labelFPassword => "סיסמה?";

  @override
  String get labelFMessage => "אל תדאג!\nאנא הזן את האימייל המושיך לחשבון שלך";

  /// ************ Registration labels ************///
  @override
  String get labelRegister => "הירשם";

  @override
  String get registerSuccess => "ברוך הבא! נרשמתם בהצלחה";

  @override
  String get labelAlreadyHaveAcc => "כבר יש לך חשבון?";

  @override
  String get labelLoginNow => "התחבר!";

  @override
  String get labelRepeatPass => "חזור על הסיסמה";

  @override
  String get labelRegistrationConfirmMsg => "בהרשמה את/ה מסכים על";

  @override
  String get labelTermsConditions => "תנאים & הגבלות";

  @override
  String get labelPrivacyPolicy => "מדיניות הפרטיות";

  /// ************ OTP ************///
  @override
  String get labelMobileNumber => 'מספר טלפון';

  @override
  String get labelEnterOTP => "אנא הזן את מספר הטלפון עבור אימות OTP";

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
  String get emptyUser => 'שם משתמש לא יכול להיות ריק!';

  @override
  String get emptyEmail => 'אימייל לא יכול להיות ריק';

  @override
  String get emptyPassword => 'הסיסמה לא יכולה להיות ריקה';

  @override
  String get passwordMismatch => 'סיסמאות לא תואמות';

  @override
  String get emptyAddress => 'הכתובת לא יכולה להיות ריקה';

  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "חודש";
  @override
  String get weekLabel => "שבוע";

  /// ************ Settings labels ************///
  @override
  String get reviewRatingLabel => "ביקורות & דירוגים";
  @override
  String get serviceSetupLabel => "הגדרת שירותים";
  @override
  String get scheduleManagementLabel => "ניהול לוח זמנים";
  @override
  String get businessDetailsLabel => "פרטי העסק";
  @override
  String get bookingSettingsLabel => "הגדרות זימון";
  @override
  String get personalSettingsLabel => "הגדרות אישיות";

  /// ************ Client labels ************///

  @override
  String get clientsLabel => "לקוחות";
  @override
  String get clientAppointmentsLabel => "תורי הלקוח";
  @override
  String get newClientLabel => "לקוח חדש";
  @override
  String get editClientLabel => "עריכת לקוח";
  @override
  String get clientDetailsLabel => "פרטי הלקוח";
  @override
  String get appointmentsLabel => "תורים";
  @override
  String get cancellationLabel => "ביטולים";
  @override
  String get noShowLabel => "לא הופיע";
  @override
  String get birthdayLabel => "יום הולדת";
  @override
  String get lastVisitLabel => "ביקור אחרון";
  @override
  String get discountLabel => "הנחה";
  @override
  String get totalRevenueLabel => "סך תשלומים";
  @override
  String get trustedClientLabel => "לקוח אמין";
  @override
  String get notesLabel => "הערות";
  @override
  String get showAllLabel => "התג הכל";
  @override
  String get fullNameLabel => "שם מלא";
  @override
  String get phoneNumberLabel => "מס פלאפון";
  @override
  String get emailAddressLabel => "אימייל";
  @override
  String get addressLabel => "כתובת";
  @override
  String get permissionsLabel => "הרשאות";
  @override
  String get isTrustedClientLabel => "האם לקוח אמין?";
  @override
  String get trustedClientModalBody =>
      "אם כבוי הלקוח לא יוכל להזמין פגישה אוטומטית";

  /// ************ Business Info Labels ************///
  @override
  String get businessNameLabel => "עובד";
  @override
  String get socialMediaLabel => "סוציאל מדיה";
  @override
  String get facebookLabel => "פייסבוק";
  @override
  String get instagramLabel => "אינסטגרם";
  @override
  String get websiteLabel => "אתר אינטרנט";
  @override
  String get businessDescriptionLabel => "תיאור העסק";
  @override
  String get logoLabel => "לוגו";
  @override
  String get logoDescription => "העלה את הלוגו של העסק, יוצג בפרופיל שלך";
  @override
  String get coverPhotoLabel => "תמונת רקע";
  @override
  String get coverPhotoDescription =>
      "תמונת רקע הינה הדבר הראשון שהלקוחות יראו בפרופיל שלך, הוסף תמונה כדי לתת תבונה לגביך";
  @override
  String get workplacePhotoLabel => "תמונות מהעבודה";
  @override
  String get workplacePhotoDescription =>
      "תן ללקוחות הצצה מהירה על העבודה, תעלה תמונות ותרשים את ללקוחות לפני שבאים";
  @override
  String get profileImagesLabel => "תמונת פרופיל";
  @override
  String get profileImageDescription =>
      "מה הדבר הראשון שאתה רוצה שלקוחות יראו על העסק שלך? זכור, לקוחות חדשים רוצים לראות איך הם יכולים להיראות עם השירותים שלך.";
  @override
  String get editLogoLabel => "עריכת לוגו";
  @override
  String get deleteLogoLabel => "מחקית לוגו";
  @override
  String get editCoverPhotoLabel => "עריכת תמונת רקע";
  @override
  String get deleteCoverPhotoLabel => "מחיקת תמונת רקע";
  @override
  String get deletePhotoLabel => "מחיקת תמונה";

  /// ************ Appointment Labels ************///
  @override
  String get emptyAppointmentListLabel => "אין תורים";
  @override
  String get emptyAppointmentTimeListLabel => "אין תורים ביום הזה";
  @override
  String get addNewAppointmentLabel => "הוספת תור חדש";
  @override
  String get newAppointmentLabel => "תור חדש";
  @override
  String get editAppointmentLabel => "עריכת תור";
  @override
  String get appointmentDetailsLabel => "פרטי התור";
  @override
  String get chooseServiceLabel => "בחר שירות";
  @override
  String get walkInClientLabel => "בחר לקוח או השאר ריק";
  @override
  String get totalLabel => "סך הכל";
  @override
  String get todayLabel => "היום";
  @override
  String get bookAgainLabel => "להזמין שוב";
  @override
  String get checkoutLabel => "לקופה";
  @override
  String get cancelThisAppointmentLabel => "בטל תור";
  @override
  String get addServiceLabel => "הוספת שירות";

  /// ************ Schedule Management Labels ************///
  @override
  String get workingDaysLabel => "ימי עבודה";
  @override
  String get unavailabilityLabel => "אי-זמינות";
  @override
  String get unavailabilityListLabel => "רשימת אי-זמינות";
  @override
  String get businessHoursNotesLabel => "העברות שעות פעילות";
  @override
  String get businessHoursNotesHint =>
      "תיאור קצר של שעות העבודה של העסק שלך (מומלץ)";
  @override
  String get breakLabel => "הפסקה";
  @override
  String get breaksLabel => "הפסקות";
  @override
  String get addBreakLabel => "הוספת הפסקה";
  @override
  String get workingOnThisDayLabel => "עובדים ביום הזה";
  @override
  String get dayDetailsDescriptionLabel =>
      "הגדר את שעות הפעילות שלך כאן. עבור אל לוח זמנים מתפריט ההגדרות אם אתה צריך להתאים שעות ליום בודד";
  @override
  String get startDateTimeLabel => "תאריך ושעת התחלה";
  @override
  String get reasonLabel => "סיבה";
  @override
  String get reasonHint => "תיאור קצר של הסיבה שלך (מומלץ)";

  /// ************ Service Labels ************///
  @override
  String get newServiceLabel => "שירות חדש";
  @override
  String get editServiceLabel => "עריכת שירות";
  @override
  String get serviceNameLabel => "שם שירות";
  @override
  String get priceLabel => "עלות";
  @override
  String get durationLabel => "משך";
  @override
  String get colorLabel => "צבע";
  @override
  String get descriptionLabel => "תיאור";
  @override
  String get deleteServiceLabel => "מחיקת שירות";
  @override
  String get deleteThisServiceLabel => "מחיקת שירות זה";
  @override
  String get messageToClientLabel => "הודעה ללקוח";
  @override
  String get messageToClientModalBody =>
      "הודעה זו תישלח ללקוח שלך לפני הפגישה. למשל, נא לא לאכול שעה אחת לפני התור.";
  @override
  String get clientBookPermissionLabel => "לאפשר ללקוח להזמין לבד";
  @override
  String get clientBookPermissionModalBody =>
      "אם כבוי לקוחות לא יוכלו להזמין שירות זה באמצעות האפליקציה. יהיה עליך להוסיף תור ידנית ליומן שלך";

  /// ************ Common Labels ************///
  @override
  String get notSetLabel => "לא מוכן";
  @override
  String get yesLabel => "כן";
  @override
  String get noLabel => "לא";
  @override
  String get submitLabel => "הגש";
  @override
  String get signOutLabel => "התנתק";
  @override
  String get continueLabel => "המשך";
  @override
  String get deleteLabel => "מחק";
  @override
  String get backLabel => "חזור";
  @override
  String get actionUndoneLabel => "לא ניתן לבטל את הפעולה";
  @override
  String get mediaLabel => "מדיה";
  @override
  String get addMediaLabel => "הוספת מדיה";
  @override
  String get closeLabel => "סגור";
  @override
  String get openLabel => "פתח";
  @override
  String get closedLabel => "סגור";
  @override
  String get startLabel => "התחל";
  @override
  String get confirmLabel => "אשר";
  @override
  String get endLabel => "סיום";
  @override
  String get cancelLabel => "בטל";
  @override
  String get takePhotoLabel => "צלם תמונה";
  @override
  String get chooseFromLibraryLabel => "בחר ממדיה";

  /// ************ Flash Messages ************///
  @override
  String get flashMessageSuccessTitle => "כל הכבוד!";
  @override
  String get flashMessageErrorTitle => "אוי!";
  @override
  String get clientCreatedWronglyBody => "שנה כמה דברים ונסה לשלוח שוב";
  @override
  String get clientUpdatedSuccessfullyBody => "הלקוח עודכן בהצלחה";
  @override
  String get clientCreatedSuccessfullyBody => "הלקוח נוצר בהצלחה";

  @override
  String get wpPhotoDeletedSuccessfullyBody => "תמונת העבודה נמחקה בהצלחה";

  @override
  String get serviceUpdatedSuccessfullyBody => "השירות עודכן בהצלחה";

  @override
  String get serviceCreatedSuccessfullyBody => "השירות נוצר בהצלחה";

  @override
  String get appointmentUpdatedSuccessfullyBody =>
      "your appointment have been updated successfully.";
  @override
  String get appointmentCreatedSuccessfullyBody =>
      "your appointment have been created successfully.";
  @override
  String get appointmentCancelledSuccessfullyBody =>
      "your appointment have been cancelled successfully.";
  @override
  String get clientMissingBody => "please select client in order to continue.";
  @override
  String get serviceMissingBody =>
      "please select at least one service in order to continue.";
}
