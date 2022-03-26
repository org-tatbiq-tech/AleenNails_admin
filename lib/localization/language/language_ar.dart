import 'languages.dart';

class LanguageAr extends Languages {
  /// ************ App labels ************///
  @override
  String get appName => "Delivery";

  /// ************ Common labels ************///
  @override
  String get error => "خطأ!";

  @override
  String get success => "نجحت!";

  @override
  String get sent => "أُرسل!";

  @override
  String get successSent =>
      "تم ارسال بريد لاستعادة كلمة السر بنجاح, من فضلك تحقق من بريدك!";

  @override
  String get submit => "إرسال";

  @override
  String get labelSelectLanguage => "اختر لغة";

  @override
  String get labelContinue => "Continue";

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

  ////////////////////////////////////////////////////////////////////

  /// ************ Login labels ************///
  @override
  String get labelSignIn => "تسجيل الدخول";

  @override
  String get labelEmail => "البريد الالكتروني";

  @override
  String get labelPassword => "كلمة السر";

  @override
  String get labelForgotPassword => "نسيت كلمة السر؟";

  @override
  String get labelRememberMe => "تذكرني";

  @override
  String get labelLogin => "دخول";

  @override
  String get labelNoAccount => "لم تسجّل بعد؟ ";

  @override
  String get labelRegisterNow => "سجّل الان!";

  @override
  String get labelEnterLoginDetails =>
      "Please enter the details below to continue";

  @override
  String get labelUserName => "User name";

  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "نسيت";

  @override
  String get labelFPassword => "كلمة السر؟";

  @override
  String get labelFMessage => "لا تقلق!\nأرجوك أدخل بريدك الالكتروني";

  /// ************ Registration labels ************///
  @override
  String get labelRegister => "تسجيل";

  @override
  String get registerSuccess => "أهلا وسهلا! تم تسجيلك بنجاح";

  @override
  String get labelAlreadyHaveAcc => "سجّلت من قبل؟ ";

  @override
  String get labelLoginNow => "سجّل دخولك!";

  @override
  String get labelRepeatPass => "كرر كلمة السر";

  @override
  String get labelSignOut => "تسجيل الخروج";

  @override
  String get labelRegistrationConfirmMsg => "By register you are agree to our";

  @override
  String get labelTermsConditions => "Terms & Conditions";

  @override
  String get labelPrivacyPolicy => "Privacy policy";

  /// OTP ///
  @override
  String get labelMobileNumber => 'Mobile number';

  @override
  String get labelEnterOTP =>
      "Please enter your Mobile number for OTP Authentication";

  @override
  String get labelMobileCodeSent =>
      "يرجى التحقق من هاتفك ، تم إرسال رقم التحقق";

  @override
  String get labelChange => "تغير";

  @override
  String get labelResend => "إعادة إرسال";

  /// ************ Store labels ************///
  @override
  String get labelStore => "المتجر";

  @override
  String get labelOwner => "المالك";

  @override
  String get labelStoreName => "اسم المتجر";

  @override
  String get labelStoreAddress => "موقع المتجر";

  @override
  String get labelStoreOwnerName => "صاحب المتجر";

  @override
  String get labelStoreOwnerNum => "هاتف المتجر";

  /// ************ Package labels ************///
  @override
  String get labelPackages => "طٌرود";

  @override
  String get labelStatusDelivered => "تم التسليم";

  @override
  String get labelStatusPickedUp => "تم الشحن";

  @override
  String get labelStatusWaiting => "بالانتظار";

  @override
  String get deliveredMsg => "تم تسليم الطرد!";

  @override
  String get pickedUpMsg => "تم شحن الطرد!";

  @override
  String get labelDeliveredPackages => "طُرود أٌستلمت";

  @override
  String get labelContactDetails => "تفاصيل المستلم";

  @override
  String get labelStoreDetails => "تفاصيل المتجر";

  /// ************ New Package labels ************///
  @override
  String get labelNewPackage => 'طرد جديد';

  @override
  String get labelClientName => 'اسم الزبون';

  @override
  String get labelName => 'اسم';

  @override
  String get labelClientPhone => 'رقم هاتف الزبون';

  @override
  String get labelAddress => 'الموقع';

  @override
  String get labelPrice => 'السعر';

  @override
  String get labelDescription => 'الوصف';

  @override
  String get labelDescriptionHint => "أملأ وصف للطرد اذا احوَج...";

  @override
  String get labelPublish => 'إضافة';

  @override
  String get labelUpdate => "تعديل";

  @override
  String get labelFlashPublish => 'إضافة!';

  @override
  String get publishSuccessMsg => 'تم إضافة الطرد بنجاح';

  /// ************ Profile labels ************///

  /// ************ validation messages ************///
  @override
  String get emptyPrice => 'لا يمكن أن يكون السعر فارغًا!';

  @override
  String get validPrice => 'الرجاء إدخال السعر بشكل صحيح!';

  @override
  String get validPhone => 'الرجاء إدخال رقم الهاتف بشكل صحيح!';

  @override
  String get emptyContact => 'لا يمكن أن يكون اسم جهة الاتصال فارغًا!';

  @override
  String get emptyAddress => 'لا يمكن أن يكون العنوان فارغًا!';
}
