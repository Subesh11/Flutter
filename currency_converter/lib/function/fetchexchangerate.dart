import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> convertCurrency({
  required String amount,
  required String from,
  required String to,
}) async {
  final uri = Uri.https('v1.apiplugin.io', '/v1/currency/LvmWs8Yp/convert', {
    'amount': amount,
    'from': from,
    'to': to,
  });

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to convert currency: ${response.statusCode}');
  }
}
