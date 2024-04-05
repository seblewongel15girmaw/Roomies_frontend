import 'dart:convert';

Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }
  final payload = parts[1];
  final String decoded = utf8.decode(base64Url.decode(base64Url.normalize(payload)));
  return json.decode(decoded);
}