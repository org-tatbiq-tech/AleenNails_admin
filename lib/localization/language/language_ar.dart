import 'languages.dart';

class LanguageAr extends Languages {
  ///************************************************************************///
  /// ************ App labels ************///
  @override
  String get appName => "Aleen Nails";

  ///************************************************************************///
  /// ************ Login labels ************///
  @override
  String get labelSignIn => "تسجيل الدخول";

  @override
  String get labelEmail => "البريد الالكتروني";

  @override
  String get labelPassword => "كلمة المرور";

  @override
  String get labelForgotPassword => "?نسيت كلمة السر";

  @override
  String get labelRememberMe => "تذكرني";

  @override
  String get labelEnterLoginDetails =>
      "أهلاً وسهلاً\nالرجاء إدخال التفاصيل أدناه للمتابعة";

  ///************************************************************************///
  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "نسيت";

  @override
  String get labelFPassword => "كلمة السر?";

  @override
  String get labelFMessage =>
      "لا تقلق!\nالرجاء إدخال البريد الإلكتروني المرتبط بحسابك";

  ///************************************************************************///
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

  ///************************************************************************///
  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "شهر";
  @override
  String get weekLabel => "اسبوع";

  ///************************************************************************///
  /// ************ Settings labels ************///
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

  ///************************************************************************///
  /// ************ Client labels ************///
  @override
  String get clientLabel => "العميل";
  @override
  String get clientsLabel => "عملاء";
  @override
  String get selectClientLabel => "اختار عميل";
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
  String get isTrustedClientLabel => "؟هل العميل موثوق";
  @override
  String get trustedClientModalBody =>
      "في حالة الإغلاق ، لن يتمكن العميل من حجز موعد تلقائيًا.";
  @override
  String get noClientsAddedLabel => "لا يوجد عملاء";
  @override
  String get addNewClientLabel => "أضف عميل جديد";
  @override
  String get approveClientLabel => "الموافقة على العميل";
  @override
  String get rejectClientLabel => "حظر العميل";
  @override
  String get isBlockedClientLabel => "؟هل العميل محظور";
  @override
  String get blockedClientLabel => "عميل محظور";
  @override
  String get blockedClientModalBody =>
      "في حالة الإغلاق ، لن يتمكن العميل من الدخول للتطبيق.";

  ///************************************************************************///
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

  ///************************************************************************///
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

  ///************************************************************************///
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
  @override
  String get openingCalendarLabel => "فتح التقويم";
  @override
  String get openingCalendarMessage => "ضبط ساعات العمل من أي يوم بشكل مستقل";
  @override
  String get addLeaveLabel => "أضف إجازة";
  @override
  String get addLeaveMessage => "يمكنك إغلاق المكان للنطاق الزمني المحدد";
  @override
  String get daysLabel => "أيام";

  ///************************************************************************///
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
  String get noServiceAddedLabel => "no service added yet.";
  @override
  String get addNewServiceLabel => "add new service";
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

  // Auth Errors
  @override
  String get authUserNotFoundErrorTitle => "البريد الالكتروني غير مسجل!";
  @override
  String get authUserNotFoundErrorBody =>
      "البريد الالكتروني غير مسجل, الرجاء التأكد او التسجيل";
  @override
  String get authLoginFailedErrorTitle => "فشل في الاتصال!";
  @override
  String get authLoginFailedErrorBody =>
      "لم نستطع الاتصال بالنظام, الرجاء اعادة التجربة لاحقاً";
  @override
  String get authWrongPassErrorTitle => "معطيات غير ملائمة!";
  @override
  String get authWrongPassErrorBody =>
      "البريد الالكتروني او كلمة المرور غير صحيح";
  @override
  String get authAdminErrorTitle => "لست مُشرف";
  @override
  String get authAdminErrorBody => "البريد الالكتروني غير مسجّل كمُشرف";

  // Validations
  @override
  String get validationEmptyFieldError => "المعطى لا يمكن ان يكون فارغ!";
  @override
  String get validationEmptyMobileError => "رقم الهاتف لا يمكن ان يكون فارغ!";
  @override
  String get validationMobileInvalidError =>
      "رقم الهاتف غير صحيح! يجب ان يكون 10 ارقام";
  @override
  String get validationEmptyEmailError =>
      "البريد الالكتروني لا يمكن ان يكون فارغ!";
  @override
  String get validationEmailInvalidError =>
      "البريد الالكتروني غير صحيح, يجب ان يكون كما يلي hello@mail.com";
  @override
  String get validationPasswordInvalidError =>
      "كلمة المرور قصيرة جدا! على الاقل 6 احرف وارقام";
  @override
  String get validationEmptyPasswordError =>
      "كلمة المرور لا يمكن ان تكون فارغه!";
  @override
  String get validationMismatchingPasswordError => "كلمات المرور غير متطابقة!";
  @override
  String get validationURLInvalidError => "الرابط غير صحيح";
  @override
  String get validationEmptyPriceError => "السعر لا يمكن ان يكون فارغ!";
  @override
  String get validationPriceInvalidError => "الرجاء ادخال سعر صحيح";

  ///************************************************************************///
  /// ************ Notification Labels ************///
  @override
  String get rejectLabel => "رفض";
  @override
  String get approveLabel => "قبول";
  @override
  String get approvalRequestLabel => "قبول الطلب";

  ///************************************************************************///
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
  String get finishedLabel => "finished";
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
  String get enabledLabel => "enabled";
  @override
  String get disabledLabel => "disabled";
  @override
  String get okLabel => "ok";
  @override
  String get hoursLabel => "hours";
  @override
  String get minsLabel => "mins";
  @override
  String get arrowLabel => "←";
  @override
  String get statusLabel => "status";
  @override
  String get timeLabel => "time";
  @override
  String get locationLabel => "location";
  @override
  String get currentLocationLabel => "current location";
  @override
  String get updateBusinessLocationLabel => "update business location";

  ///************************************************************************///
  /// ************ Flash Messages ************///
  @override
  String get flashMessageSuccessTitle => "رائع!";
  @override
  String get flashMessageErrorTitle => "اوه!";
  @override
  String get clientCreatedWronglyBody =>
      "قم بتغيير بعض الأشياء وحاول الإرسال مرة أخرى.";
  @override
  String get clientPhoneAlreadyUsedErrorBody =>
      "رقم الهاتف مسجل لعميل اخر. قم بتغيير رقم الهاتف وحاول مرة أخرى.";
  @override
  String get clientEmailAlreadyUsedErrorBody =>
      "البريد مسجل لعميل اخر. قم بتغييره وحاول مرة أخرى.";
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
  String get serviceDeletedSuccessfullyBody =>
      "your service have been deleted successfully.";
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
  @override
  String get resetPassEmailSentTitle => "أُرسل!";
  @override
  String get resetPassEmailSentSuccessBody =>
      "تم ارسال بريد لاستعادة كلمة السر بنجاح, من فضلك تحقق من بريدك!";
  @override
  String get resetPassEmailSentErrorTitle => "حدث خطأ!";
  @override
  String get resetPassEmailSentErrorBody =>
      "حدث خطأ في إعادة تعيين كلمة المرور! من فضلك جرب مرة اخرى";

  ///************************************************************************///
  /// ************ Profile settings ************///
  @override
  String get labelPersonalSettings => "إعدادات شخصية";
  @override
  String get labelNotification => "إشعارات";
  @override
  String get noNotificationsMsg => "لا يوجد اشعارات";
  @override
  String get notificationsTitle => "إشعارات التطبيق";
  @override
  String get notificationsMsg => "اسمح بإرسال إشعارات (هذا الهاتف)";
  @override
  String get labelNotifyBy => "من قِبَل";
  @override
  String get labelSettings => "إعدادات";
  @override
  String get labelLanguage => "لغة";
  @override
  String get languageMsg => "حدد لغة التطبيق";
  @override
  String get labelLogout => "تسجيل خروج";
  @override
  String get labelLater => "لاحقا";
  @override
  String get logoutMsg => 'هل تريد تسجيل الخروج من التطبيق؟';

  ///************************************************************************///
  /// ************ Week days ************///
  @override
  String get labelSunday => "ألأحد";
  @override
  String get labelMonday => "ألاثنين";
  @override
  String get labelTuesday => "ألثلاثاء";
  @override
  String get labelWednesday => "ألأربعاء";
  @override
  String get labelThursday => "ألخميس";
  @override
  String get labelFriday => "ألجمعة";
  @override
  String get labelSaturday => "ألسبت";

  ///************************************************************************///
  /// ************ Booking settings ************///
  @override
  String get labelBookingRules => "قواعد الحجز";
  @override
  String get labelRules => "القواعد";
  @override
  String get labelBookingInAdvanceTitle => "حجز مواعيد مقدما حتى";
  @override
  String get labelBookingInAdvanceModal => "حجز مقدم حتى";
  @override
  String get labelFutureBooking => "حجز مواعيد مستقبلية حتى";
  @override
  String get labelFutureBookingModal => "حجز مستقبلا حتى";
  @override
  String get labelReschedulingWindow => "امكانيّة تغيير مواعيد حتى";
  @override
  String get labelReschedulingWindowModal => "ممكن تغيير مواعيد حتى";
  @override
  String get labelAutomaticallyConfirm => "قبول الادوار تلقائيا";
  @override
  String get labelAutomaticallyConfirmMsg =>
      "قبول الادوار تلقائيا توفر الوقت وتسهّل على المتخدمين في تعيين الادوار, مُستحسن!";

  /// Booking lists///
  @override
  String get notLessThan15Mins => 'على الاقل قبل 15 دقيقة';
  @override
  String get notLessThan30Mins => 'على الاقل قبل 30 دقيقة';
  @override
  String get notLessThan1H => 'على الاقل قبل 1 ساعات';
  @override
  String get notLessThan2H => 'على الاقل قبل 2 ساعات';
  @override
  String get notLessThan3H => 'على الاقل قبل 3 ساعات';
  @override
  String get notLessThan6H => 'على الاقل قبل 6 ساعات';
  @override
  String get notLessThan12H => 'على الاقل قبل 12 ساعات';
  @override
  String get notLessThan1D => 'على الاقل قبل 1 ايام';
  @override
  String get notLessThan2D => 'على الاقل قبل 2 ايام';
  @override
  String get notLessThan3D => 'على الاقل قبل 3 ايام';
  @override
  String get notLessThan5D => 'على الاقل قبل 5 ايام';

  /// Future booking
  @override
  String get upTo7Days => 'حتى 7 ايام';
  @override
  String get upTo14Days => 'حتى 14 يوم';
  @override
  String get upTo1Month => 'حتى شهر';
  @override
  String get upTo2Months => 'حتى 2 اشهر';
  @override
  String get upTo3Months => 'حتى 3 اشهر';
  @override
  String get upTo6Months => 'حتى 6 اشهر';

  /// Rescheduling
  @override
  String get notBefore1Hour => "حتى ساعة";
  @override
  String get notBefore2Hours => "حتى ساعتين";
  @override
  String get notBefore3Hours => "حتى 3 ساعات";
  @override
  String get notBefore6Hours => "حتى 6 ساعات";
  @override
  String get notBefore12Hours => "حتى 12 ساعة";
  @override
  String get notBefore1Day => "حتى يوم";
  @override
  String get notBefore2Days => "حتى 2 ايام";
  @override
  String get notBefore3Days => "حتى 3 ايام";
  @override
  String get notBefore5Days => "حتى 5 ايام";
  @override
  String get notBefore7Days => "حتى 7 ايام";

  /// Booking settings msgs
  @override
  String get labelAutomaticallyConfirmMsgCompletion =>
      "If turned off, Admin will have to manually confirm each customer booking. Please note: Your availability is only updated upon confirmation, not based in requests. this means you could receive multiple customer request for the same time slot.";
  @override
  String get labelBookingInAdvanceExplanation =>
      "How mch of a window do you need between the time of booking and the appointment time? This helps you to plan ahead and eliminates any surprises appointments.";
  @override
  String get labelFutureBookingExplanation =>
      "Choose how far in the future clients can schedule appointments if you want to encourage repeat bookings we recommend setting this for a longer time period.";
  @override
  String get labelReschedulingExplanation =>
      "Choose how long before an appointment a client can reschedule or cancel.";

  /// Discount
  @override
  String get labelAddDiscount => "إضافة تخيض";
  @override
  String get labelNewPrice => "السعر بعد التخفيض";

  @override
  String get locationDisabled => 'خدمة تحديد الموقع غير مفعلة';
  @override
  String get locationDenied => 'تم رفض اذن تحديد الموقع';
  @override
  String get locationTotallyDenied =>
      'تم رفض أذن الموقع بشكل دائم ، ولا يمكننا طلب أذن';

  /// Filters
  @override
  String get filters => "المرشحات";
  @override
  String get dateRange => "نطاق الموعد";
  @override
  String get status => "الحالة";
  @override
  String get serviceType => "نوع الخدمة";
  @override
  String get clearAll => "امسح الكل";
  @override
  String get applyFilters => "تطبيق المرشحات";
  @override
  String get allLabel => "الكل";
}
