import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentis_ai/screens/evolution_system/evolution_system.dart';
import 'package:mentis_ai/screens/user_profile/user_profile.dart';
import 'package:mentis_ai/screens/user_profile/user_settings.dart';
import 'package:mentis_ai/utils/autentication.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mentis_ai/screens/evolution_system/evolution_system_steps.dart';
import 'package:mentis_ai/screens/login/login.dart';
import 'package:mentis_ai/screens/home/home.dart';
import 'package:mentis_ai/screens/screening_system/screening_system.dart';
import 'utils/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);

  // Carregar variáveis de ambiente (não deve quebrar se o arquivo não for encontrado)
  try {
    await dotenv.load(fileName: '.env');
    debugPrint('✅ .env carregado');
  } catch (e) {
    // Mostra aviso e continua — não podemos permitir crash na inicialização por causa do .env
    debugPrint('⚠️ Não foi possível carregar o arquivo .env: $e');
  }

  // Inicializar Firebase para todas as plataformas
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
  }

  runApp(const MentisApp());
}

class MentisApp extends StatelessWidget {
  const MentisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentisAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: {
        '/home': (context) => const Home(),
        '/screening-system': (context) => const ScreeeningSystem(),
        '/evolution-system': (context) => const EvolutionSystem(),
        '/evolution-system-steps': (context) => const EvolutionSystemSteps(),
        '/user-profile': (context) => const UserProfile(),
        '/user-settings': (context) => const UserSettings(), 
      },
      home: const Home(),
    );
  }
}
