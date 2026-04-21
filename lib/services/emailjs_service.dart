import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailJSService {
  static String get _serviceId => dotenv.env['EMAILJS_SERVICE_ID'] ?? '';
  static String get _templateId => dotenv.env['EMAILJS_TEMPLATE_ID'] ?? '';
  static String get _publicKey => dotenv.env['EMAILJS_PUBLIC_KEY'] ?? '';

  // 1. Generate 6 Digit OTP
  static String generateOTP() {
    return (100000 + Random().nextInt(900000)).toString();
  }

  // 2. Send OTP via EmailJS
  static Future<Map<String, dynamic>> sendOTP({required String userEmail}) async {
    try {
      final otp = generateOTP();
      final expiryTime = DateTime.now().add(const Duration(minutes: 15));
      final formattedTime = "${expiryTime.hour.toString().padLeft(2, '0')}:${expiryTime.minute.toString().padLeft(2, '0')}";

      // 🔥 PRINTING FOR DEBUGGING
      print("--------------------------");
      print("📩 SENDING OTP TO: $userEmail");
      print("🔢 GENERATED OTP: $otp");
      print("⏰ EXPIRY TIME: $formattedTime");
      print("--------------------------");

      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost', 
        },
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey, 
          'template_params': {
            'email': userEmail,    // ✅ Matches {{email}} in your dashboard
            'passcode': otp,       // ✅ Matches {{passcode}}
            'time': formattedTime, // ✅ Matches {{time}}
          },
        }),
      );

      print("📡 EMAILJS STATUS: ${response.statusCode}");
      print("📄 EMAILJS RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return {
          'success': true, 
          'otp': otp, 
          'expiryTime': expiryTime.toIso8601String()
        };
      } else {
        return {'success': false, 'error': response.body};
      }
    } catch (e) {
      print("❌ EMAILJS EXCEPTION: $e");
      return {'success': false, 'error': e.toString()};
    }
  }

  // 3. Verify OTP (Required for the OTP Screen)
  static bool verifyOTP({
    required String inputOTP,
    required String actualOTP,
    required String expiryTimeISO,
  }) {
    final expiryTime = DateTime.parse(expiryTimeISO);
    if (DateTime.now().isAfter(expiryTime)) {
      print("⌛ OTP EXPIRED");
      return false;
    }
    return inputOTP == actualOTP;
  }
}
