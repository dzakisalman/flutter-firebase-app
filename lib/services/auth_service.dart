import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("User cancelled the Google sign-in");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (user.displayName == null) {
          await user.updateDisplayName(googleUser.displayName);
          await user.reload();
        }

        print('User ${user.email} berhasil login dengan Google');
        print('Waktu login: ${DateTime.now()}');
      }

      return _auth.currentUser;
    } catch (e) {
      print("Error saat login dengan Google: $e");
      return null;
    }
  }

  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await Future.delayed(Duration(milliseconds: 500));
        await userCredential.user!.reload();

        final updatedUser = _auth.currentUser;
        if (updatedUser != null) {
          print('User baru terdaftar:');
          print('Email: ${updatedUser.email}');
          print('Nama: ${updatedUser.displayName}');
          print('Waktu registrasi: ${DateTime.now()}');
        }
        return updatedUser;
      }
      return null;
    } catch (e) {
      print("Error saat registrasi: $e");
      return null;
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        print('User ${userCredential.user!.email} berhasil login dengan email');
        print('Waktu login: ${DateTime.now()}');
      }

      return userCredential.user;
    } catch (e) {
      print("Error saat login dengan email: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print('User ${user.email} telah logout');
        print('Waktu logout: ${DateTime.now()}');
      }

      await _googleSignIn.signOut();
      await _auth.signOut();
      print("User signed out successfully");
    } catch (e) {
      print("Error saat logout: $e");
    }
  }
}
