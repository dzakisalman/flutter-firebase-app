import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("User cancelled the Google sign-in");
        return null;
      }

      // Ambil autentikasi Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Buat kredensial Firebase dari token Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Masuk ke Firebase dengan kredensial Google
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Update display name jika belum ada
        if (user.displayName == null) {
          await user.updateDisplayName(googleUser.displayName);
          await user.reload();
        }

        // Log aktivitas
        print('User ${user.email} berhasil login dengan Google');
        print('Waktu login: ${DateTime.now()}');
      }

      return _auth.currentUser;
    } catch (e) {
      print("Error saat login dengan Google: $e");
      return null;
    }
  }

  // Registrasi dengan email, password, dan nama
  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        // Tunggu sebentar untuk memastikan data terupdate
        await Future.delayed(Duration(milliseconds: 500));
        // Reload user untuk mendapatkan data terbaru
        await userCredential.user!.reload();

        final updatedUser = _auth.currentUser;
        if (updatedUser != null) {
          // Log aktivitas
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

  // Login dengan email dan password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Log aktivitas
        print('User ${userCredential.user!.email} berhasil login dengan email');
        print('Waktu login: ${DateTime.now()}');
      }

      return userCredential.user;
    } catch (e) {
      print("Error saat login dengan email: $e");
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Log aktivitas
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
