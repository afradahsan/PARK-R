import 'package:parkr/data/models/bookingmodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  static final instance = Razorpay();

  static Future<void> checkoutOrder(BookingModel bookingmodel,
      {required Function(PaymentSuccessResponse) onSuccess,
      required Function(PaymentFailureResponse) onFailure}) async {
    var options = {
      'key': 'rzp_test_JOthFkpJyGOCeW',
      'order_id': bookingmodel.razorpayId,
      'name': 'Parkwiser App',
      'description': bookingmodel.parkingLot,
      'amount': bookingmodel.totalPrice * 100,
      'currency': 'INR'
    };

    instance.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response);
      instance.clear();
    });

    instance.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onFailure(response);
      instance.clear();
    });

    instance.open(options);
  }
}
