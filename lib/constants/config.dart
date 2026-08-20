class Config {
  static const String baseUrl = "https://getproz.com/goservices_updated/api/";
  static const String imageUrl = "https://getproz.com/goservices_updated/";

  static const String loginUrl = "${baseUrl}partnerlogin";
  static const String signUpUrl = "${baseUrl}partner_register";
  static const String profileUrl = "${baseUrl}partnerProfile";
  static const String profileUpdateUrl = "${baseUrl}partner_profile_update";
  static const String updatePassUrl = "${baseUrl}profileupdatepassword";

  static const String leadListUrl = "${baseUrl}booking_list_for_partner";
  static const String serviceDetailsUrl = "${baseUrl}onbookingclick";
  static const String buyBookingUrl = "${baseUrl}partnerbuybooking";
  static const String startBookingUrl = "${baseUrl}partnerstartbooking";
  static const String markedAsCompleteUrl = "${baseUrl}partnermarkedcompleted";

  static const String onGoingUrl = "${baseUrl}partnerongoing";
  static const String historyUrl = "${baseUrl}partnerbookinghistory";
  static const String withdrawalUrl = "${baseUrl}complete_ord";

  static const String upiUrl = "${baseUrl}update_upi";
  static const String sendReqUrl = "${baseUrl}send_withdrawreq";

  static const String bankAddUrl = "${baseUrl}bank";
  static const String bankUpdateUrl = "${baseUrl}bankupdate";
  static const String bankShowUrl = "${baseUrl}banklisting";

  static const String gstAddUrl = "${baseUrl}documentation";
  static const String gstUpdateUrl = "${baseUrl}documentationupdate";
  static const String gstShowUrl = "${baseUrl}documentationlist";

  static const String allEarningsUrl = "${baseUrl}leadboughthistory";
  static const String rechargeHistoryUrl = "${baseUrl}rechargehistory";
  static const String rechargePlanUrl = "${baseUrl}rechargeplan";

  static const String termsConditionsUrl = "${baseUrl}terms_condition";
  static const String contactUsUrl = "${baseUrl}about_us";
  static const String addOrderUrl = "${baseUrl}rechargevalueinsert";
  static const String coinsUrl = "${baseUrl}partnercoins";

  static const String forgotPassUrl = "${baseUrl}partner_pass_otp";
  static const String verifyOtpUrl = "${baseUrl}verify_otp_pass";
  static const String updatePartnerPassUrl = "${baseUrl}update_partner_pass";
}
