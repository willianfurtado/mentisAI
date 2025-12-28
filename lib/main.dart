import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentis_ai/screens/login/login.dart';
import 'package:mentis_ai/screens/evolution_system/evolution_system.dart';
import 'package:mentis_ai/screens/user_profile/user_profile.dart';
import 'package:mentis_ai/screens/user_profile/user_settings.dart';
import 'package:mentis_ai/screens/evolution_system/evolution_system_steps.dart';
import 'package:mentis_ai/screens/home/home.dart';
import 'package:mentis_ai/screens/screening_system/screening_system.dart';
import 'utils/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);

  try {
    await dotenv.load(fileName: '.env');
    debugPrint('✅ .env carregado');
  } catch (e) {
    debugPrint('⚠️ Não foi possível carregar o arquivo .env: $e');
  }

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
        '/login': (context) => const Login(),
      },
      home: const AuthGate(),
    );
  }
}
//Fazer a verificação de autenticação, se o usuário está logado ou não;
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const Home();
        }

        return const Login(); // <--- Certifique-se que o widget de login chama LoginScreen
      },
    );
  }
}
