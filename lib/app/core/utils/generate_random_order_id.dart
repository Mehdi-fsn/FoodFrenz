import 'dart:math';

String generateRandomOrderId() {
  final random = Random();
  const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const digits = '0123456789';

  String orderId = '';

  for (int i = 0; i < 8; i++) {
    if (i % 2 == 0) {
      orderId += digits[random.nextInt(digits.length)];
    } else {
      orderId += letters[random.nextInt(letters.length)];
    }
  }

  return orderId;
}
