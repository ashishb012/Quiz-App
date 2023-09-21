import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';

import 'package:quiz/services/auth/auth_user.dart';
import 'package:quiz/services/auth/auth_provider.dart';
import 'package:quiz/services/auth/auth_exceptions.dart';

import 'package:quiz/firebase_options.dart';

class FirebaseAuthProvider implements EmailAuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> emailCreateUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw NullUserAuthExceptions();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthExceptions();
      } else if (e.code == "email-already-in-use") {
        throw EmailInUseAuthExceptions();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthExceptions();
      } else {
        throw AuthExceptions();
      }
    } catch (e) {
      throw AuthExceptions();
    }
  }

  @override
  Future<AuthUser> emailLogIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw NullUserAuthExceptions();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        throw WrongPasswordAuthExceptions();
      } else if (e.code == "user-not-found") {
        throw NullUserAuthExceptions();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthExceptions();
      } else {
        throw AuthExceptions();
      }
    } catch (e) {
      throw AuthExceptions();
    }
  }

  @override
  Future<void> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw NullUserAuthExceptions();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification();
    } else {
      throw NullUserAuthExceptions();
    }
  }

  @override
  Future<void> sendPasswordResetLink({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw InvalidEmailAuthExceptions();
      } else if (e.code == "user-not-found") {
        throw NullUserAuthExceptions();
      } else {
        throw AuthExceptions();
      }
    } catch (_) {
      throw AuthExceptions();
    }
  }
}


// genreating / getting sha keys (sha1 & sha-256)
// In the terminal change the directory to the "Android" folder in the project
// Then execute this command - ./gradlew signingReport
// Scroll up to get the Desired SHA keys