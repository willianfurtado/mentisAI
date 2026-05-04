import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mentis_ai/services/health_sync_service.dart';

class AIService {
  final Uri url = Uri.parse('http://192.168.1.107:8000');

  Future<Map<String, dynamic>?> predictUserStatus(Map<String, dynamic> healthData) async {
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'aplication/json',
          'Accept': 'application/json', 
        },
        body: json.encode(healthData)
      );

      if(response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        print("Erro no Servidor: ${response.statusCode} - ${response.body}");
      }

    } catch(e) {
      print("Erro ao conectar com a IA: $e");
    }
  }

  final HealthSyncService healthSyncService = HealthSyncService();

  // Future data = await healthSyncService.pushDatatoModel(date);



  Future<void> sendDataToServer(data) async {
    
  }

  
}