import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentis_ai/screens/evolutionSystem/main.dart';
import 'package:mentis_ai/screens/login.dart';
import 'package:mentis_ai/screens/home/home.dart';
import 'package:mentis_ai/screens/screeningSystem/screening_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase apenas em Android/iOS (têm google-services.json ou GoogleService-Info.plist)
  // No Windows, Web e Desktop, Firebase não é necessário para este teste
  // if (defaultTargetPlatform == TargetPlatform.android ||
  //     defaultTargetPlatform == TargetPlatform.iOS) {
  //   try {
  //     await Firebase.initializeApp();
  //   } catch (e) {
  //     debugPrint('⚠️ Firebase initialization failed on mobile: $e');
  //   }
  // } else {
  //   // Em Desktop/Web, desabilitar Firebase de forma segura
  //   try {
  //     // Dummy init para evitar erros de plugins
  //     debugPrint('ℹ️ Firebase skipped on ${defaultTargetPlatform.name}');
  //   } catch (e) {
  //     debugPrint('⚠️ Error skipping Firebase: $e');
  //   }
  // }

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
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
        '/screening-system': (context) => const ScreeeningSystem(),
        '/evolution-system': (context) => const EvolutionSystem(),
      },
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     // Enquanto verifica, mostrar loading
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Scaffold(
      //         body: Center(child: CircularProgressIndicator()),
      //       );
      //     }

      //     // Se tem dados (usuário logado), vai para Home
      //     if (snapshot.hasData) {
      //       return const Home();
      //     }

      //     // Senão, mostra Login
      //     return const Login();
      //   },
      // ),
    );
  }
}
