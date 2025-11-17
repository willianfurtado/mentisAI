import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mentis_ai/firebase_options.dart';
import 'package:mentis_ai/screens/login.dart';
import 'package:mentis_ai/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.dotenv.load(fileName: ".env");

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MentisApp());
}

class MentisApp extends StatefulWidget {
  const MentisApp({super.key});

  @override
  State<MentisApp> createState() => _MentisAppState();
}

class _MentisAppState extends State<MentisApp> {
  GoogleSignInAccount? _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    _setupAuthListeners();
  }

  Future<void> _checkCurrentUser() async {
    try {
      final currentUser = GoogleSignIn.instance.currentUser;
      if (currentUser != null) {
        setState(() {
          _user = currentUser;
        });
      }
    } catch (e) {
      print('Erro ao verificar usuário atual: $e');
    }
  }

  void _setupAuthListeners() {
    GoogleSignIn.instance.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      setState(() {
        _user = account;
      });
    });
  }

  // Método para sign out correto
  Future<void> _signOut() async {
    await GoogleSignIn.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentisAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: _user == null
          ? Login(googleSignIn: GoogleSignIn.instance)
          : Home(googleSignIn: GoogleSignIn.instance, onSignOut: _signOut),
    );
  }
}
