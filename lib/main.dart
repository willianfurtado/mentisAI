import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importante para verificar o status;
import 'package:mentis_ai/firebase_options.dart';
import 'package:mentis_ai/screens/login.dart';
import 'package:mentis_ai/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // Inicializa Firebase;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        // O StreamBuilder é o "porteiro". Ele vigia o Firebase Auth.
        home: Home() //StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     // 1. Enquanto verifica, pode mostrar um loading (opcional)
        //     if (snapshot.connectionState == ConnectionState.waiting) { //não está pronto ainda
        //       return const Scaffold(
        //         body: Center(child: CircularProgressIndicator()),
        //       );
        //     }

        //     // 2. Se tem dados (usuário logado), vai para Home
        //     if (snapshot.hasData) {
        //       return const Home();
        //       // Nota: Se sua Home recebia parâmetros antigos, remova-os.
        //       // A Home agora deve pegar o usuário via FirebaseAuth.instance.currentUser
        //     }
        //   },
        // ),
        );
  }
}
