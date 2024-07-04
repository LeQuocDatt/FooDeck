import 'package:template/source/export.dart';

const double kLatitude = 10.7758439;
const double kLongitude = 106.7017555;
const int deliveryFee = 10;
const int vat = 4;
const int coupon = 4;

int get totalPrice {
  int addonPrice = cartItems.fold(
      0, (previousValue, element) => previousValue + element.price);
  return addonPrice;
}

int get bill {
  int getBill = totalPrice + deliveryFee + vat - coupon;
  return getBill;
}
