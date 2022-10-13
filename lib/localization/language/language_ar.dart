import 'languages.dart';

class LanguageAr extends Languages {
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
  String get labelSignIn => "تسجيل الدخول";

  @override
  String get labelEmail => "الريد الالكتروني";

  @override
  String get labelPassword => "كلمة المرور";

  @override
  String get labelForgotPassword => "?نسيت كلمة السر";

  @override
  String get labelRememberMe => "تذكرني";

  @override
  String get labelLogin => "تسجيل دخول";

  @override
  String get labelNoAccount => "لا تملك حساب؟";

  @override
  String get labelRegisterNow => "سجّل الان!";

  @override
  String get labelEnterLoginDetails => "الرجاء إدخال التفاصيل أدناه للمتابعة";

  @override
  String get labelUserName => "اسم المستخدم";

  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "نسيت";

  @override
  String get labelFPassword => "كلمة السر?";

  @override
  String get labelFMessage =>
      "لا تقلق!\nالرجاء إدخال البريد الإلكتروني المرتبط بحسابك";

  /// ************ Registration labels ************///
  @override
  String get labelRegister => "سجّل";

  @override
  String get registerSuccess => "اهلا وسهلا! لقد تم تسجيلك!";

  @override
  String get labelAlreadyHaveAcc => "هل لديك حساب؟";

  @override
  String get labelLoginNow => "تسجيل دخول!";

  @override
  String get labelRepeatPass => "اعد كلمة السر";

  @override
  String get labelRegistrationConfirmMsg => "بالتسجيل فأنت توافق على";

  @override
  String get labelTermsConditions => "البنود والشروط";

  @override
  String get labelPrivacyPolicy => "سياسة الخصوصية";

  /// ************ OTP ************///
  @override
  String get labelMobileNumber => 'رقم الهاتف';

  @override
  String get labelEnterOTP => "يرجى إدخال رقم هاتفك المحمول لمصادقة OTP";

  @override
  String get labelMobileCodeSent =>
      "يرجى التحقق من هاتفك ، تم إرسال رمز التحقق";

  @override
  String get labelChange => "تغيير";

  @override
  String get labelResend => "إعادة إرسال";

  /// ************ validation messages ************///
  @override
  String get validPhone => 'الرجاء إدخال رقم هاتف صحيح!';

  @override
  String get emptyUser => 'لا يمكن أن يكون اسم المستخدم فارغًا';

  @override
  String get emptyEmail => 'لا يمكن أن يكون البريد الإلكتروني فارغًا';

  @override
  String get emptyPassword => 'لا يمكن أن تكون كلمة المرور فارغة';

  @override
  String get passwordMismatch => 'كلمات السر غير متطابقة';

  @override
  String get emptyAddress => 'Address can not be empty';

  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "شهر";
  @override
  String get weekLabel => "اسبوع";

  /// ************ Settings labels ************///
  @override
  String get reviewRatingLabel => "المراجعات & التقييمات";
  @override
  String get serviceSetupLabel => "إعداد الخدمات";
  @override
  String get scheduleManagementLabel => "إدارة الجدول الزمني";
  @override
  String get businessDetailsLabel => "تفاصيل العمل";
  @override
  String get bookingSettingsLabel => "إعدادات الحجز";
  @override
  String get personalSettingsLabel => "اعدادات شخصية";

  /// ************ Client labels ************///
  @override
  String get clientLabel => "العميل";
  @override
  String get clientsLabel => "عملاء";
  @override
  String get clientAppointmentsLabel => "مواعيد العميل";
  @override
  String get newClientLabel => "عميل جديد";
  @override
  String get editClientLabel => "تعديل عميل";
  @override
  String get clientDetailsLabel => "تفاصيل العميل";
  @override
  String get appointmentsLabel => "مواعيد";
  @override
  String get cancellationLabel => "إلغاء";
  @override
  String get noShowLabel => "عدم حضور";
  @override
  String get birthdayLabel => "تاريخ الولاده";
  @override
  String get lastVisitLabel => "الزيارة الأخيرة";
  @override
  String get discountLabel => "تخفيض";
  @override
  String get totalRevenueLabel => "اجمالي الدخل";
  @override
  String get trustedClientLabel => "عميل موثوق";
  @override
  String get notesLabel => "ملاحظات";
  @override
  String get showAllLabel => "عرض الكل";
  @override
  String get fullNameLabel => "الاسم الكامل";
  @override
  String get phoneNumberLabel => "رقم الهاتف";
  @override
  String get emailAddressLabel => "البريد الالكترونى";
  @override
  String get addressLabel => "العنوان";
  @override
  String get permissionsLabel => "أذونات";
  @override
  String get isTrustedClientLabel => "هل العميل موثوق";
  @override
  String get trustedClientModalBody =>
      "في حالة الإغلاق ، لن يتمكن العميل من حجز موعد تلقائيًا.";

  /// ************ Business Info Labels ************///
  @override
  String get businessLabel => "العمل";
  @override
  String get businessNameLabel => "عمل";
  @override
  String get socialMediaLabel => "وسائل التواصل الاجتماعي";
  @override
  String get facebookLabel => "فيسبوك";
  @override
  String get instagramLabel => "انتسغرام";
  @override
  String get websiteLabel => "موقع الكتروني";
  @override
  String get wazeLabel => "waze";
  @override
  String get businessDescriptionLabel => "وصف العمل";
  @override
  String get businessDescriptionHint =>
      "short description of your business (recommended)";
  @override
  String get businessNameInfoLabel => "business name & info";
  @override
  String get logoLabel => "شعار";
  @override
  String get logoDescription =>
      "قم بتحميل شعار عملك حتى يكون مرئيًا في ملفك الشخصي.";
  @override
  String get coverPhotoLabel => "صورة الغلاف";
  @override
  String get coverPhotoDescription =>
      "صورة الغلاف الخاصة بك هي أول ما يراه عملاؤك في ملفك الشخصي. أضف صورة لمنحهم نظرة ثاقبة حول العمل";
  @override
  String get workplacePhotoLabel => "صورة مكان العمل";
  @override
  @override
  String get workplacePhotoDescription =>
      "امنح العملاء نظرة خاطفة على عملك قبل الحجز";
  @override
  String get profileImagesLabel => "صور الملف الشخصي";
  @override
  String get profileImageDescription =>
      "ما هو أول شيء تريد أن يراه العملاء بشأن عملك؟ تذكر أن العملاء الجدد يرغبون في رؤية الشكل الذي يمكن أن يبدو عليه مع خدماتك";
  @override
  String get editLogoLabel => "تعديل الشعار";
  @override
  String get deleteLogoLabel => "حذف الشعار";
  @override
  String get addLogoLabel => "add logo";
  @override
  String get addCoverPhotoLabel => "add cover photo";
  @override
  String get editCoverPhotoLabel => "تحرير صورة الغلاف";
  @override
  String get deleteCoverPhotoLabel => "حذف صورة الغلاف";
  @override
  String get deletePhotoLabel => "حذف الصورة";

  /// ************ Appointment Labels ************///
  @override
  String get emptyAppointmentListLabel => "لم يتم إضافة موعد بعد";
  @override
  String get emptyAppointmentTimeListLabel => "لا يوجد موعد في هذا اليوم";
  @override
  String get addNewAppointmentLabel => "إضافة موعد جديد";
  @override
  String get newAppointmentLabel => "موعد جديد";
  @override
  String get editAppointmentLabel => "تعديل الموعد";
  @override
  String get appointmentDetailsLabel => "تفاصيل الموعد";
  @override
  String get chooseServiceLabel => "اختر الخدمة";
  @override
  String get walkInClientLabel => "حدد عميلاً أو اتركه فارغًا";
  @override
  String get totalLabel => "المجموع";
  @override
  String get todayLabel => "اليوم";
  @override
  String get bookAgainLabel => "احجز مرة أخرى";
  @override
  String get checkoutLabel => "الدفع";
  @override
  String get cancelThisAppointmentLabel => "إلغاء هذا الموعد";
  @override
  String get addServiceLabel => "أضف خدمة";

  /// ************ Schedule Management Labels ************///
  @override
  String get workingDaysLabel => "أيام العمل";
  @override
  String get unavailabilityLabel => "غير متاح";
  @override
  String get unavailabilityDeleteLabel => "למחוק אי-זמינות";
  @override
  String get unavailabilityListLabel => "قائمة غير-متاح";
  @override
  String get businessHoursNotesLabel => "ملاحظات ساعات العمل";
  @override
  String get businessHoursNotesHint => "وصف موجز لساعات عملك (مفضل)";
  @override
  String get breakLabel => "استراحة";
  @override
  String get breaksLabel => "استراحات";
  @override
  String get addBreakLabel => "أضف استراحة";
  @override
  String get workingOnThisDayLabel => "اعمل في هذا اليوم";
  @override
  String get dayDetailsDescriptionLabel =>
      "اضبط ساعات عملك هنا. توجه إلى التقويم من قائمة الإعدادات إذا كنت بحاجة إلى ضبط ساعات يوم معيّن";
  @override
  String get startDateTimeLabel => "تاريخ وساعة البداية";
  @override
  String get reasonLabel => "السبب";
  @override
  String get reasonHint => "وصف قصير للسبب (مفضل)";

  /// ************ Service Labels ************///
  @override
  String get serviceLabel => "خدمة";
  @override
  String get servicesLabel => "الخدمات";
  @override
  String get newServiceLabel => "خدمة جديدة";
  @override
  String get editServiceLabel => "تعديل خدمة";
  @override
  String get serviceNameLabel => "اسم الخدمة";
  @override
  String get priceLabel => "السعر";
  @override
  String get durationLabel => "المدة";
  @override
  String get colorLabel => "اللون";
  @override
  String get descriptionLabel => "الوصف";
  @override
  String get deleteServiceLabel => "خذف الخدمة";
  @override
  String get deleteThisServiceLabel => "احذف هذه الخدمة";
  @override
  String get messageToClientLabel => "رسالة للعميل";
  @override
  String get messageToClientModalBody =>
      "سيتم إرسال هذه الرسالة إلى العميل قبل الموعد. على سبيل المثال، يرجى عدم تناول الطعام قبل ساعة واحدة من الموعد";
  @override
  String get clientBookPermissionLabel => "السماح للعميل بالحجز";
  @override
  String get clientBookPermissionModalBody =>
      "إذا تم اغلاق هذه الخدمة ،فلن يتمكنوا من حجز هذه الخدمة باستخدام التطبيق. سيكون عليك إضافة موعد يدويًا إلى التقويم الخاص بك";

  /// ************ Common Labels ************///
  @override
  String get notSetLabel => "غير مضبوط";
  @override
  String get yesLabel => "نعم";
  @override
  String get noLabel => "لا";
  @override
  String get submitLabel => "تم";
  @override
  String get signOutLabel => "خروج";
  @override
  String get continueLabel => "متابعة";
  @override
  String get deleteLabel => "حذف";
  @override
  String get backLabel => "رجوع";
  @override
  String get actionUndoneLabel => "لا يمكن التراجع عن الإجراء";
  @override
  String get mediaLabel => "الصور";
  @override
  String get addMediaLabel => "اضافة صورة";
  @override
  String get closeLabel => "اغلق";
  @override
  String get openLabel => "افتح";
  @override
  String get closedLabel => "مغلق";
  @override
  String get startLabel => "ابدأ";
  @override
  String get startTimeLabel => "start time";
  @override
  String get endTimeLabel => "end time";
  @override
  String get confirmLabel => "تأكيد";
  @override
  String get endLabel => "نهاية";
  @override
  String get cancelLabel => "الغاء";
  @override
  String get takePhotoLabel => "التقاط صورة";
  @override
  String get chooseFromLibraryLabel => "اختر من المكتبة";
  @override
  String get idLabel => "هوية";
  @override
  String get waitingLabel => "waiting";
  @override
  String get confirmedLabel => "confirmed";
  @override
  String get cancelledLabel => "cancelled";
  @override
  String get declinedLabel => "declined";
  @override
  String get paidLabel => "paid";
  @override
  String get unpaidLabel => "unpaid";
  @override
  String get saveLabel => "save";
  @override
  String get okLabel => "ok";

  /// ************ Flash Messages ************///
  @override
  String get flashMessageSuccessTitle => "رائع!";
  @override
  String get flashMessageErrorTitle => "اوه!";
  @override
  String get clientCreatedWronglyBody =>
      "قم بتغيير بعض الأشياء وحاول الإرسال مرة أخرى.";
  @override
  String get clientUpdatedSuccessfullyBody => "تم تعديل العميل بنجاح";
  @override
  String get clientCreatedSuccessfullyBody => "تم إنشاء العميل بنجاح";

  @override
  String get wpPhotoDeletedSuccessfullyBody => "تم حذف صورة مكان عملك بنجاح";
  @override
  String get wpPhotoUploadedSuccessfullyBody =>
      "your workplace photo have been uploaded Successfully.";
  @override
  String get logoPhotoDeletedSuccessfullyBody =>
      "your logo photo have been deleted Successfully.";
  @override
  String get covePhotoPhotoDeletedSuccessfullyBody =>
      "your cover photo photo have been deleted Successfully.";
  @override
  String get logoPhotoUploadedSuccessfullyBody =>
      "your logo photo have been uploaded Successfully.";
  @override
  String get coverPhotoPhotoUploadedSuccessfullyBody =>
      "your cover photo photo have been uploaded Successfully.";

  @override
  String get serviceUpdatedSuccessfullyBody => "تم تعديل الخدمة بنجاح";

  @override
  String get serviceCreatedSuccessfullyBody => "تم إنشاء الخدمة بنجاح";
  @override
  String get appointmentUpdatedSuccessfullyBody => "تم تعديل الموعد بنجاح";
  @override
  String get appointmentCreatedSuccessfullyBody => "تم إنشاء الموعد بنجاح";
  @override
  String get appointmentCancelledSuccessfullyBody => "تم إلغاء الموعد بنجاح";
  @override
  String get clientMissingBody => "الرجاء تحديد العميل للمتابعة";
  @override
  String get serviceMissingBody => "يرجى تحديد خدمة واحدة على الأقل للمتابعة";
  @override
  String get adminMissingTitle => "لست مشرف!";
  @override
  String get adminMissingBody => "هذا البريد الالكتروني غير مسجّل كمشرف";
  @override
  String get infoUpdatedSuccessfullyBody =>
      "your info have been updated successfully.";
  @override
  String get workingDayUpdatedSuccessfullyBody =>
      "your working day have been updated successfully.";
  @override
  String get unavailabilityUpdatedSuccessfullyBody =>
      "your unavailability have been updated successfully.";
  @override
  String get unavailabilityDeletedSuccessfullyBody =>
      "your unavailability have been deleted successfully.";

  /// ************ Languages ************///
  @override
  String get labelEnglish => "ألانجليزية";
  @override
  String get labelHebrew => "العبرية";
  @override
  String get labelArabic => "العربية";
}
