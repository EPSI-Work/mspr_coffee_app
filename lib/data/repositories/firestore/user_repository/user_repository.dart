import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mspr_coffee_app/data/models/user/user.dart';
import 'package:mspr_coffee_app/data/services/auth/firebase_auth_repository.dart';

class UserRepository {
  static String ressource = 'users';
  FirebaseFirestore firestore;
  FirebaseAuthRepository _firebaseAuthRepository = FirebaseAuthRepository();

  UserRepository({FirebaseFirestore? firestore})
      : this.firestore =
            (firestore != null) ? firestore : FirebaseFirestore.instance;

  CollectionReference<User> fetchAllByCustomFilter() {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return reference;
  }

  Future fetchAll() async {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (habit, _) => habit.toJson(),
        );
    return await reference.get().then((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future fetchOne({
    required String docId,
  }) async {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (habit, _) => habit.toJson(),
        );
    return await reference.doc(docId).get().then((snapshot) {
      return snapshot.data();
    });
  }

  Future<User> insert({
    required User entity,
  }) async {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (habit, _) => habit.toJson(),
        );
    return await reference.doc(entity.uid).set(entity).then((_) {
      return entity;
    });
  }

  Future remove({required String docId}) async {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (habit, _) => habit.toJson(),
        );
    return await reference.doc(docId).delete().then((_) {
      return true;
    });
  }

  Future<User> update({required User entity}) async {
    final reference = firestore.collection(ressource).withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (habit, _) => habit.toJson(),
        );
    return await reference
        .doc(entity.uid.toString())
        .update(entity.toJson())
        .then((_) {
      return entity;
    });
  }

  Future<void> resetPassword({required String email}) async {
    return await _firebaseAuthRepository.resetPassword(email);
  }
}
