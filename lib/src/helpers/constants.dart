import 'package:flutter/material.dart';

// const String baseUrl = "https://shopsasta.com/";
const String baseUrl = "https://dev.shopsasta.com/";
// const String baseUrl = "http://cbad911499ef.ngrok.io/";
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6Ijk1NTA0Nzk4ODEiLCJpYXQiOjE2MTM0MDA3ODUsImV4cCI6MTYyODk1Mjc4NX0.eTurFtCI6p8jf9yZebJdaZxVvWkF5VAYnp_g-yL5LAA

// {name: "Vijay", email: "vijay@shopsasta.com", phone: "9550479881", que: "", title: "Orders"}
// email: "vijay@shopsasta.com"
// name: "Vijay"
// phone: "9550479881"----
// que: ""
// title: "Orders"
// const String baseUrl = "http://3.6.90.124:9000/";
const String loginEndPoint = "api/user-login/";
const String verifyOtpEndPoint = "api/user-verify/";
const String userAddEndPoint = "api/user/";
const String userGroupEndPoint = "api/user-group";
const String producListEndPoint = "category/groceries/vegetables?json=1";
const String producDataEndPoint = "?json=1";
const String cartEndPoint = "api/cart/";
const String noRushEndPoint = "api/norush-delivery/";
const String regEndPoint = "api/regular-delivery/";
const String cartUpdateEndPoint = "api/cart/update";
const String cartCouponEndPoint = "api/cart/coupon";
const String cartRCouponEndPoint = "api/cart/remove-coupon";
const String createOrderEndPoint = "api/order/create-v2";
const String cancelOrderEndPoint = "/api/order-cancel";
const String configRefEndPoint = "/api/referral-cashback";
const String getOrderEndPoint = "api/order/v2";
const String getCategoryEndPoint = "?json=1";
const String firebaseEndPoint = "/api/usertoken-update";
const String paytmEndPoint = "/order/paytm";
const String stockStatusEndPoint = "api/check-pincode-serviceable";
const String removeCashbacksEndPoint = "api/remove-discounts";
const String supportEndPoint = "api/support-mail/";
const String cartVerifyEndPoint = "/api/cart-verify";
const String cartConfirmEndPoint = "/api/cart-confirm";
const String minOrdAmtEndPoint = "/api/sasta-delivery";
const String faqEndPoint = "api/faqs";
const String cityEndPoint = "api/cities";

const String earningEndPoint = "api/user-earnings";
const String summaryEndPoint = "api/user-earnings-summary";

//---------------webviewlinks-----------

const String howItWorks = "pages-mob/how-it-works/";
// const String termConditions = "pages/terms-and-conditions/";
const String termConditions = "pages-mob/terms-and-conditions/";
const String deliveryCoverage = "pages-mob/delivery-coverage/";
const String aboutUs = "pages-mob/about-us/";
const String privacyPolicy = "pages-mob/privacy-policy/";
const String vendorResources = "pages-mob/vendor/";
const String cancellationPolicy = "pages-mob/cancellation-policy/";
const String returnRefund = "pages-mob/return-refund/";
const String paymentWebView = "order/paytm?txnid=";
const String sastaWebView = "sasta-deals-mob";

const String awsLink =
    "https://shop-sasta.s3.ap-south-1.amazonaws.com/shopsasta/";
List<String> productImg = [
  "https://www.bigbasket.com/media/uploads/p/s/10000423_10-bb-royal-sooji-ordinarybombay-rava.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/40026597_3-bb-royal-wheat-brokendalia.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/40189427_2-super-saver-wheat-flour-atta.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/40072491_13-bb-royal-organic-soojirawa.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/10000469_14-bb-royal-ragi-flournachni-atta.jpg",
  "https://www.bigbasket.com/media/uploads/p/mm/40044725_4-bb-royal-corn-flour-starch.jpg",
  "https://www.bigbasket.com/media/uploads/p/mm/40079750_6-bb-royal-organic-whole-wheat-atta.jpg"
];
String kg = " 1KG ", quan = '1 @ ₹375';

List<String> catName = [
  "Bhasmati Rice",
  "Wheat Floor Atta",
  "Royal Organic Atta",
  "Royal Wheat ",
  "Ragi Flour Atta",
  "Rice Brand"
];
Map<String, Color> color = {
  "add": Color.fromRGBO(0, 150, 136, 1),
  "plus": Color.fromRGBO(7, 195, 177, 1)
};
List<int> catPrize = [259, 299, 349, 146, 544];
List<String> catList = [
  "https://www.bigbasket.com/media/uploads/p/s/271035_3-freedom-refined-oil-sunflower.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/40189427_2-super-saver-wheat-flour-atta.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/40072491_13-bb-royal-organic-soojirawa.jpg",
  "https://www.bigbasket.com/media/uploads/p/s/10000469_14-bb-royal-ragi-flournachni-atta.jpg",
  "https://www.bigbasket.com/media/uploads/p/mm/40079750_6-bb-royal-organic-whole-wheat-atta.jpg"
];
// List<String> recItem = [
//   "https://www.bigbasket.com/media/uploads/p/s/10000423_10-bb-royal-sooji-ordinarybombay-rava.jpg",
//   "https://freepngimg.com/thumb/grocery/41619-7-groceries-free-download-image-thumb.png",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRbqvWyjoCTt8P6LnMdFCl2NlSZ0tx63rs6YA",
//   "https://www.bigbasket.com/media/uploads/p/mm/40044725_4-bb-royal-corn-flour-starch.jpg",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS_9dYMlHrdoRm2_m3P2Ti-v0RW4LzYT4gnzw",
// ];
List<String> icons = [
  "https://as1.ftcdn.net/jpg/01/67/39/08/500_F_167390836_Vu1z2kidJvTnmv9QvdviTJI5Ip6b97WV.jpg",
  "https://as1.ftcdn.net/jpg/01/67/39/08/500_F_167390836_Vu1z2kidJvTnmv9QvdviTJI5Ip6b97WV.jpg",
  "https://as1.ftcdn.net/jpg/01/67/39/08/500_F_167390836_Vu1z2kidJvTnmv9QvdviTJI5Ip6b97WV.jpg",
  "https://as2.ftcdn.net/jpg/01/06/64/93/500_F_106649327_qYETPEfYcSVADcTXZhMSBjQG94azwSec.jpg",
  "https://as1.ftcdn.net/jpg/01/67/39/08/500_F_167390836_Vu1z2kidJvTnmv9QvdviTJI5Ip6b97WV.jpg",
  "https://as1.ftcdn.net/jpg/01/67/39/08/500_F_167390836_Vu1z2kidJvTnmv9QvdviTJI5Ip6b97WV.jpg",
  "https://as2.ftcdn.net/jpg/01/06/64/93/500_F_106649327_qYETPEfYcSVADcTXZhMSBjQG94azwSec.jpg",
  "https://as2.ftcdn.net/jpg/01/67/39/09/500_F_167390973_9SOSvhMxcmXpdVuRXmYvKTrOUj6n7MB7.jpg",
];
List<String> productCategory = [
  "All",
  "Grocery",
  "Spices",
  "Oils",
  "Dry Fruits& Nuts",
  "Household"
];
List<String> searchCategory = [
  "Grocery",
  "Spices",
  "Oils",
  "Dry Fruits& Nuts",
  "Household",
  "Home & Kitchen",
  "Apparel",
  "Mobiles",
  "Electronics"
];
