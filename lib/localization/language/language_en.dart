import 'languages.dart';

class LanguageEn extends Languages {
  ///************************************************************************///
  /// ************ App labels ************///
  @override
  String get appName => "Aleen Nails";

  ///************************************************************************///
  /// ************ Login labels ************///
  @override
  String get labelSignIn => "Sign In";
  @override
  String get labelEmail => "Email";
  @override
  String get labelPassword => "Password";
  @override
  String get labelForgotPassword => "Forgot password?";
  @override
  String get labelRememberMe => "Remember me";
  @override
  String get labelEnterLoginDetails =>
      "Welcome!\nPlease enter the details below to continue";

  ///************************************************************************///
  /// ************ Forgot pass labels ************///
  @override
  String get labelForgot => "Forgot";
  @override
  String get labelFPassword => "Password?";
  @override
  String get labelFMessage =>
      "Do not worry! it happens.\nPlease enter email associated to your account";

  ///************************************************************************///
  /// ************ validation messages ************///
  @override
  String get validPhone => 'Please enter valid phone number!';
  @override
  String get emptyUser => 'Contact name can NOT be empty';
  @override
  String get emptyEmail => 'Email can NOT be empty';
  @override
  String get emptyPassword => 'Password can NOT be empty';
  @override
  String get passwordMismatch => 'Passwords mismatch';
  @override
  String get emptyAddress => 'Address can NOT be empty';

  ///************************************************************************///
  /// ************ Calendar labels ************///
  @override
  String get monthLabel => "Month";
  @override
  String get weekLabel => "Week";

  ///************************************************************************///
  /// ************ Settings labels ************///
  @override
  String get serviceSetupLabel => "services setup";
  @override
  String get scheduleManagementLabel => "schedule management";
  @override
  String get businessDetailsLabel => "business details";
  @override
  String get bookingSettingsLabel => "booking settings";
  @override
  String get personalSettingsLabel => "personal settings";

  ///************************************************************************///
  /// ************ Client labels ************///
  @override
  String get clientLabel => "client";
  @override
  String get clientsLabel => "clients";
  @override
  String get selectClientLabel => "select client";
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
  String get noClientsAddedLabel => "no client added yet";
  @override
  String get addNewClientLabel => "add new client";

  ///************************************************************************///
  /// ************ Business Info Labels ************///
  @override
  String get businessLabel => "business";
  @override
  String get businessNameLabel => "working";
  @override
  String get socialMediaLabel => "social media";
  @override
  String get facebookLabel => "facebook";
  @override
  String get instagramLabel => "instagram";
  @override
  String get websiteLabel => "website";
  @override
  String get wazeLabel => "waze";
  @override
  String get businessDescriptionLabel => "business description";
  @override
  String get businessDescriptionHint =>
      "short description of your business (recommended)";
  @override
  String get businessNameInfoLabel => "business name & info";
  @override
  String get logoLabel => "logo";
  @override
  String get logoDescription =>
      "Upload your business logo so its visible on your profile.";
  @override
  String get coverPhotoLabel => "cover photo";
  @override
  String get coverPhotoDescription =>
      "Your cover photo is the first thing that your customers seen on your profile. Add a photo to give them  insight into what you are all about";
  @override
  String get workplacePhotoLabel => "workplace photo";
  @override
  String get workplacePhotoDescription =>
      "Give clients a sneak peek of your space before they even walk through the door.";
  @override
  String get profileImagesLabel => "profile images";
  @override
  String get profileImageDescription =>
      "What is the first thing you want clients to see about your business? Remember, new clients want to see what they could look like with your services.";
  @override
  String get editLogoLabel => "edit logo";
  @override
  String get deleteLogoLabel => "delete logo";
  @override
  String get addLogoLabel => "add logo";
  @override
  String get addCoverPhotoLabel => "add cover photo";
  @override
  String get editCoverPhotoLabel => "edit cover photo";
  @override
  String get deleteCoverPhotoLabel => "delete cover photo";
  @override
  String get deletePhotoLabel => "delete photo";

  ///************************************************************************///
  /// ************ Appointment Labels ************///
  @override
  String get emptyAppointmentListLabel => "no appointment added yet";
  @override
  String get emptyAppointmentTimeListLabel => "no appointment on this day";
  @override
  String get addNewAppointmentLabel => "add new appointment";
  @override
  String get newAppointmentLabel => "new appointment";
  @override
  String get editAppointmentLabel => "edit appointment";
  @override
  String get appointmentDetailsLabel => "appointment details";
  @override
  String get chooseServiceLabel => "choose service";
  @override
  String get walkInClientLabel => "select a client or leave empty from walk-in";
  @override
  String get totalLabel => "total";
  @override
  String get todayLabel => "today";
  @override
  String get bookAgainLabel => "book again";
  @override
  String get checkoutLabel => "checkout";
  @override
  String get cancelThisAppointmentLabel => "cancel this appointment";
  @override
  String get addServiceLabel => "add service";

  ///************************************************************************///
  /// ************ Schedule Management Labels ************///
  @override
  String get workingDaysLabel => "working days";
  @override
  String get unavailabilityLabel => "unavailability";
  @override
  String get unavailabilityDeleteLabel => "delete unavailability";
  @override
  String get unavailabilityListLabel => "unavailability list";
  @override
  String get businessHoursNotesLabel => "business hours notes";
  @override
  String get businessHoursNotesHint =>
      "short description of your business working hours (recommended)";
  @override
  String get breakLabel => "break";
  @override
  String get breaksLabel => "breaks";
  @override
  String get addBreakLabel => "add break";
  @override
  String get workingOnThisDayLabel => "working on this day";
  @override
  String get dayDetailsDescriptionLabel =>
      "set your business hours here. Head to Opening Calendar from Settings menu if you need to adjust hours for single day.";
  @override
  String get startDateTimeLabel => "start date & time";
  @override
  String get reasonLabel => "reason";
  @override
  String get reasonHint => "short description of your reason (recommended)";

  ///************************************************************************///
  /// ************ Service Labels ************///
  @override
  String get serviceLabel => "service";
  @override
  String get servicesLabel => "services";
  @override
  String get newServiceLabel => "new service";
  @override
  String get editServiceLabel => "edit service";
  @override
  String get serviceNameLabel => "service name";
  @override
  String get noServiceAddedLabel => "no service added yet.";
  @override
  String get addNewServiceLabel => "add new service";
  @override
  String get priceLabel => "price";
  @override
  String get durationLabel => "duration";
  @override
  String get colorLabel => "color";
  @override
  String get descriptionLabel => "description";
  @override
  String get deleteServiceLabel => "delete service";
  @override
  String get deleteThisServiceLabel => "delete this service";
  @override
  String get messageToClientLabel => "message to client";
  @override
  String get messageToClientModalBody =>
      "this message will be sent to your client before the appointment. E.g please don't eat 1 hour before the appointment.";
  @override
  String get clientBookPermissionLabel => "allow client to book online";
  @override
  String get clientBookPermissionModalBody =>
      "if switched off clients will not be able to book this service using the app. You will have to manually add appointment to your calendar";

  ///************************************************************************///
  /// ************ Common Labels ************///
  @override
  String get notSetLabel => "not set";
  @override
  String get yesLabel => "yes";
  @override
  String get noLabel => "no";
  @override
  String get submitLabel => "submit";
  @override
  String get signOutLabel => "Sign out";
  @override
  String get continueLabel => "continue";
  @override
  String get deleteLabel => "delete";
  @override
  String get backLabel => "back";
  @override
  String get actionUndoneLabel => "action can't be undone";
  @override
  String get mediaLabel => "media";
  @override
  String get addMediaLabel => "add media";
  @override
  String get closeLabel => "close";
  @override
  String get openLabel => "open";
  @override
  String get closedLabel => "closed";
  @override
  String get startLabel => "start";
  @override
  String get startTimeLabel => "start time";
  @override
  String get endTimeLabel => "end time";
  @override
  String get confirmLabel => "confirm";
  @override
  String get endLabel => "end";
  @override
  String get cancelLabel => "cancel";
  @override
  String get takePhotoLabel => "take a photo";
  @override
  String get chooseFromLibraryLabel => "choose from library";
  @override
  String get idLabel => "id";
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
  @override
  String get hoursLabel => "hours";
  @override
  String get minsLabel => "mins";
  @override
  String get arrowLabel => "→";
  @override
  String get statusLabel => "status";
  @override
  String get timeLabel => "time";

  ///************************************************************************///
  /// ************ Flash Messages ************///
  @override
  String get flashMessageSuccessTitle => "well done!";
  @override
  String get flashMessageErrorTitle => "oh snap!";
  @override
  String get clientCreatedWronglyBody =>
      "change a few things up and try submitting again.";
  @override
  String get clientPhoneAlreadyUsedErrorBody =>
      "phone number already used by another user. please change the phone number and try again.";
  @override
  String get clientUpdatedSuccessfullyBody =>
      "your client have been updated successfully.";
  @override
  String get clientCreatedSuccessfullyBody =>
      "your client have been created successfully.";
  @override
  String get wpPhotoDeletedSuccessfullyBody =>
      "your workplace photo have been deleted Successfully.";
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
  String get serviceUpdatedSuccessfullyBody =>
      "your service have been updated successfully.";
  @override
  String get serviceCreatedSuccessfullyBody =>
      "your service have been created successfully.";
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
  @override
  String get adminMissingTitle => "Not admin";
  @override
  String get adminMissingBody => "This email is not registered as Admin";
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
  String get resetPassEmailSentTitle => "Sent!";
  @override
  String get resetPassEmailSentSuccessBody =>
      "Reset email sent successfully. Please check you email!";
  @override
  String get resetPassEmailSentErrorTitle => "Reset error!";
  @override
  String get resetPassEmailSentErrorBody =>
      "Reset password failed. Please try again";

  ///************************************************************************///
  /// ************ Profile settings ************///
  @override
  String get labelPersonalSettings => "Personal Settings";
  @override
  String get labelNotification => "Notifications";
  @override
  String get notificationsTitle => "App notifications";
  @override
  String get notificationsMsg => "Send push notifications (this device)";
  @override
  String get labelNotifyBy => "Notify by";
  @override
  String get labelSettings => "Settings";
  @override
  String get labelLanguage => "Language";
  @override
  String get languageMsg => "Select application language";
  @override
  String get labelLogout => "Logout";
  @override
  String get labelLater => "later";
  @override
  String get logoutMsg => 'Logout from the Application?';

  ///************************************************************************///
  /// ************ Week days ************///
  @override
  String get labelSunday => "Sunday";
  @override
  String get labelMonday => "Monday";
  @override
  String get labelTuesday => "Tuesday";
  @override
  String get labelWednesday => "Wednesday";
  @override
  String get labelThursday => "Thursday";
  @override
  String get labelFriday => "Friday";
  @override
  String get labelSaturday => "Saturday";
}
