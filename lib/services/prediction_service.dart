import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  final Uri url = Uri.parse('');

  Future<Map<String, dynamic>?> getPredictionCluster(Map<String, dynamic> healthData) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(healthData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Erro no Servidor: ${response.statusCode} - ${response.body}");
        return null;
      }

    } catch(e) {
      print("Erro: $e");
      return null;
    }
  }
}