class RouteNames {
  RouteNames._internalConstructor();

  static final RouteNames _instance = RouteNames._internalConstructor();

  factory RouteNames() {
    return _instance;
  }

  static const String kInitialRoute = "/";
  static const String kSignInPageRoute = "/Sign_In_Page_Route";
  static const String kHomePageRoute = "/Home_Page_Route";
  static const String kUserProfilePageRoute = "/User_Profile_Page_Route";
  static const String kIdentifyPageRoute = "/Identify_Page_Route";
  static const String kRegisterPageRoute = "/Register_Page_Route";
  static const String kTrainingPageRoute = "/Training_Page_Route";
  static const String kCustomPhotoViewPageRoute =
      "/Custom_Photo_View_Page_Route";
}
