import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// Não navegar a partir daqui — o app principal deve reagir ao estado do Auth
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase(BuildContext context) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    // Firebase não está disponível em Desktop (Windows, Linux, macOS)
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Login com Google não está disponível no desktop. Use Android ou iOS.')));
      }
      return null;
    }

    try {
      debugPrint('🔵 Iniciando login com Google...');

      // Fazer login com Google
      final googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount == null) {
        debugPrint('🔴 Usuário cancelou o login');
        return null; // usuário cancelou
      }

      debugPrint('✅ Google SignIn bem-sucedido: ${googleSignInAccount.email}');

      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      debugPrint('✅ Google Authentication obtida');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Tentar fazer login no Firebase
      debugPrint('🔵 Fazendo login no Firebase...');
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = userCredential.user;

      debugPrint('✅ Login Firebase bem-sucedido: ${user?.email}');
    } on FirebaseAuthException catch (e) {
      debugPrint('🔴 Firebase Auth Exception: ${e.code} - ${e.message}');
      final message = e.message ?? 'Falha na autenticação';
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      debugPrint('🔴 Erro geral no login: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro no login: ${e.toString()}')));
      }
    }

    if ((user != null)) {
      debugPrint('🟢 Login finalizado, usuário: ${user.email}');
    } else {
      debugPrint('🔴 user é null após tentativa de login');
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign out feito com sucesso')));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Erro ao sair')));
      }
    }
  }
}
