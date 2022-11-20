import 'languages.dart';

class LanguageHe extends Languages {
  ///************************************************************************///
  /// ************ App labels ************///
  @override
  String get appName => "Aleen Nails";

  ///************************************************************************///
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
  String get labelEnterLoginDetails =>
      "ברוכים הבאים!\nאנא הזן את הפרטים למטה כדי להמשיך";

  ///************************************************************************///
  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "שכחת";
  @override
  String get labelFPassword => "סיסמה?";
  @override
  String get labelFMessage => "אל תדאג!\nאנא הזן את האימייל המשוייך לחשבון שלך";

  ///************************************************************************///
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

  ///************************************************************************///
  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "חודש";
  @override
  String get weekLabel => "שבוע";

  ///************************************************************************///
  /// ************ Settings labels ************///
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

  ///************************************************************************///
  /// ************ Client labels ************///
  @override
  String get clientLabel => "הלקוח";
  @override
  String get clientsLabel => "לקוחות";
  @override
  String get selectClientLabel => "בחר לקוח";
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
  String get birthdayLabel => "תאריך לידה";
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
  String get showAllLabel => "הצג הכל";
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
  String get isTrustedClientLabel => "האם הלקוח אמין?";
  @override
  String get trustedClientModalBody =>
      "אם כבוי, הלקוח לא יהיה ביכולתו להזמין תור לבד";
  @override
  String get noClientsAddedLabel => "עדיין לא נוסף לקוח";
  @override
  String get addNewClientLabel => "הוסף לקוח חדש";

  ///************************************************************************///
  /// ************ Business Info Labels ************///
  @override
  String get businessLabel => "העסק";
  @override
  String get businessNameLabel => "שם העסק";
  @override
  String get socialMediaLabel => "מדיה";
  @override
  String get facebookLabel => "פייסבוק";
  @override
  String get instagramLabel => "אינסטגרם";
  @override
  String get websiteLabel => "אתר אינטרנט";
  @override
  String get wazeLabel => "waze";
  @override
  String get businessDescriptionLabel => "תיאור העסק";
  @override
  String get businessDescriptionHint => "תיאור קצר על העסק (מומלץ)";
  @override
  String get businessNameInfoLabel => "שם העסק & פרטים";
  @override
  String get logoLabel => "לוגו";
  @override
  String get logoDescription => "העלאת תמונת פרופיל, מומלץ להעלות תמונת לוגו";
  @override
  String get coverPhotoLabel => "תמונת רקע";
  @override
  String get coverPhotoDescription =>
      "תמונת רקע הינה הדבר הראשון שהלקוחות יראו בפרופיל שלך, הוסף תמונה כדי לתת המחשה על העסק";
  @override
  String get workplacePhotoLabel => "תמונות מהעבודה";
  @override
  String get workplacePhotoDescription =>
      "תן ללקוחות הצצה מהירה על העבודה, תעלה תמונות ותרשים את הלקוחות לפני שבאים!";
  @override
  String get profileImagesLabel => "תמונות פרופיל";
  @override
  String get profileImageDescription =>
      "זכור, לקוחות חדשים תמיד ירצו לראות תוצאות קודם!\nבחלון הזה, תוכל להציג את העבודה, השירותים, הלוגו,...";
  @override
  String get editLogoLabel => "עריכת לוגו";
  @override
  String get deleteLogoLabel => "מחיקת לוגו";
  @override
  String get addLogoLabel => "הוספת לוגו";
  @override
  String get addCoverPhotoLabel => "הוספת תמונת רקע";
  @override
  String get editCoverPhotoLabel => "עריכת תמונת רקע";
  @override
  String get deleteCoverPhotoLabel => "מחיקת תמונת רקע";
  @override
  String get deletePhotoLabel => "מחיקת תמונה";

  ///************************************************************************///
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

  ///************************************************************************///
  /// ************ Schedule Management Labels ************///
  @override
  String get workingDaysLabel => "ימי עבודה";
  @override
  String get unavailabilityLabel => "אי-זמינות";
  @override
  String get unavailabilityDeleteLabel => "למחוק אי-זמינות";
  @override
  String get unavailabilityListLabel => "רשימת אי-זמינות";
  @override
  String get businessHoursNotesLabel => "הערות";
  @override
  String get businessHoursNotesHint =>
      "תיאור קצר של שעות העבודה של העסק (מומלץ)";
  @override
  String get breakLabel => "הפסקה";
  @override
  String get breaksLabel => "הפסקות";
  @override
  String get addBreakLabel => "הוספת הפסקה";
  @override
  String get workingOnThisDayLabel => "האם עובדים ביום הזה";
  @override
  String get dayDetailsDescriptionLabel =>
      "הגדר את שעות הפעילות שלך כאן. עבור אל לוח זמנים מתפריט ההגדרות אם אתה צריך להתאים שעות ליום בודד";
  @override
  String get startDateTimeLabel => "תאריך ושעת התחלה";
  @override
  String get reasonLabel => "סיבה";
  @override
  String get reasonHint => "הסבר קצר על סיבת האי-זמינות (מומלץ)";

  ///************************************************************************///
  /// ************ Service Labels ************///
  @override
  String get serviceLabel => "שירות";
  @override
  String get servicesLabel => "שירותים";
  @override
  String get newServiceLabel => "שירות חדש";
  @override
  String get editServiceLabel => "עריכת שירות";
  @override
  String get serviceNameLabel => "שם שירות";
  @override
  String get noServiceAddedLabel => "עדיין לא נוסף שירות";
  @override
  String get addNewServiceLabel => "הוסף שירות חדש";
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
      "הודעה זו תישלח ללקוח לפני הפגישה. למשל, נא לא לאכול שעה אחת לפני התור.";
  @override
  String get clientBookPermissionLabel => "לאפשר ללקוח להזמין לבד";
  @override
  String get clientBookPermissionModalBody =>
      "אם כבוי לקוחות לא יוכלו להזמין שירות זה באמצעות האפליקציה. יהיה עליך להוסיף תור ידנית ליומן שלך";

  ///************************************************************************///
  /// ************ Common Labels ************///
  @override
  String get notSetLabel => "לא קיים";
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
  String get startLabel => "התחלה";
  @override
  String get startTimeLabel => "זמן התחלה";
  @override
  String get endTimeLabel => "זמן סיום";
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
  @override
  String get idLabel => "מזהה";
  @override
  String get waitingLabel => "ממתין";
  @override
  String get confirmedLabel => "מאושר";
  @override
  String get cancelledLabel => "מבוטל";
  @override
  String get declinedLabel => "נדחה";
  @override
  String get paidLabel => "שולם";
  @override
  String get unpaidLabel => "לא שולם";
  @override
  String get saveLabel => "שמור";
  @override
  String get okLabel => "אוקי";
  @override
  String get hoursLabel => "שעות";
  @override
  String get minsLabel => "דקות";
  @override
  String get arrowLabel => "←";
  @override
  String get statusLabel => "סטטוס";
  @override
  String get timeLabel => "זמן";

  ///************************************************************************///
  /// ************ Flash Messages ************///
  @override
  String get flashMessageSuccessTitle => "כל הכבוד!";
  @override
  String get flashMessageErrorTitle => "אוי!";
  @override
  String get clientCreatedWronglyBody => "שנה כמה דברים ונסה לשלוח שוב";
  @override
  String get clientPhoneAlreadyUsedErrorBody =>
      "מספר הטלפון כבר רשום אצל לקוח קיים. נא לשנות את מספר הטלפון ולנסות שוב.";
  @override
  String get clientUpdatedSuccessfullyBody => "הלקוח עודכן בהצלחה";
  @override
  String get clientCreatedSuccessfullyBody => "הלקוח נוצר בהצלחה";
  @override
  String get wpPhotoDeletedSuccessfullyBody => "תמונת העבודה נמחקה בהצלחה";
  @override
  String get wpPhotoUploadedSuccessfullyBody =>
      "תמונת מקום העבודה הועלתה בהצלחה";
  @override
  String get logoPhotoDeletedSuccessfullyBody => "תמונת הלוגו נמחקה בהצלחה";
  @override
  String get covePhotoPhotoDeletedSuccessfullyBody => "תמונת הרקע נמחקה בהצלחה";
  @override
  String get logoPhotoUploadedSuccessfullyBody => "תמונת הלוגו הועלתה בהצלחה";
  @override
  String get coverPhotoPhotoUploadedSuccessfullyBody =>
      "תמונת הרקע הועלתה בהצלחה";
  @override
  String get serviceUpdatedSuccessfullyBody => "השירות עודכן בהצלחה";
  @override
  String get serviceCreatedSuccessfullyBody => "השירות נוצר בהצלחה";
  @override
  String get appointmentUpdatedSuccessfullyBody => "התור עודכן בהצלחה";
  @override
  String get appointmentCreatedSuccessfullyBody => "התור נוצר בהצלחה";
  @override
  String get appointmentCancelledSuccessfullyBody => "התור בוטל בהצלחה";
  @override
  String get clientMissingBody => "אנא בחר לקוח כדי להמשיך";
  @override
  String get serviceMissingBody => "אנא בחר שירות אחד לפחות כדי להמשיך";
  @override
  String get adminMissingTitle => "אינך מנהל!";
  @override
  String get adminMissingBody => "האימייל הזה לא רשום כמנהל";
  @override
  String get infoUpdatedSuccessfullyBody => "המידע עודכן בהצלחה";
  @override
  String get workingDayUpdatedSuccessfullyBody => "ימי העבודה עודכן בהצלחה";
  @override
  String get unavailabilityUpdatedSuccessfullyBody => "אי הזמינות עודכן בהצלחה";
  @override
  String get unavailabilityDeletedSuccessfullyBody => "אי הזמינות נמחק בהצלחה";

  ///************************************************************************///
  /// ************ Profile settings ************///
  @override
  String get labelPersonalSettings => "הגדרות אישיות";
  @override
  String get labelNotification => "התראות";
  @override
  String get notificationsTitle => "התראות האפליקציה";
  @override
  String get notificationsMsg => "מאשר שליחת התראות (המכשיר הזה)";
  @override
  String get labelNotifyBy => "הודע על ידי";
  @override
  String get labelSettings => "הגדרות";
  @override
  String get labelLanguage => "שפה";
  @override
  String get languageMsg => "בחר את שפת האפליקציה";
  @override
  String get labelLogout => "התנתק";
  @override
  String get labelLater => "אחר כך";
  @override
  String get logoutMsg => 'להתנתק מהאפליקציה?';

  /// ************ Week days ************///
  @override
  String get labelSunday => "ראשון";
  @override
  String get labelMonday => "שני";
  @override
  String get labelTuesday => "שלישי";
  @override
  String get labelWednesday => "רביעי";
  @override
  String get labelThursday => "חמישי";
  @override
  String get labelFriday => "שישי";
  @override
  String get labelSaturday => "שבת";
}
