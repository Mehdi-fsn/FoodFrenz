import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/data/providers/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider authenticationProvider;

  AuthenticationRepository(this.authenticationProvider);

  Stream<User?> get auth => authenticationProvider.authStateChanges;

  Future<void> signOut() async {
    await authenticationProvider.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    final result =
        await authenticationProvider.signIn(email: email, password: password);
    return result;
  }

  Future<String?> signInWithGoogle() async {
    final result = await authenticationProvider.signInWithGoogle();
    return result;
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    final result =
        await authenticationProvider.signUp(email: email, password: password);
    return result;
  }

  Future<String?> recoverPassword({required String email}) async {
    final result = await authenticationProvider.recoverPassword(email: email);
    return result;
  }
}
