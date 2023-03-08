import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:mspr_coffee_app/data/repositories/firestore/user_repository/user_repository.dart'
    as data_user_repository;

class UserRepository {
  final data_user_repository.UserRepository _userRepository =
      data_user_repository.UserRepository();

  Future<User> getOne({required String docId}) async {
    return User.fromDataModel(await _userRepository.fetchOne(docId: docId));
  }

  Future<List<User>> getAll() async {
    return User.listFromMapData(await _userRepository.fetchAll());
  }

  Future<User> create(User user) async {
    return User.fromDataModel(
        await _userRepository.insert(entity: user.toDataModel()));
  }

  Future<User> update(User user) async {
    return User.fromDataModel(
        await _userRepository.update(entity: user.toDataModel()));
  }

  Future<bool> delete(User user) async {
    return await _userRepository.remove(docId: user.uid.toString());
  }

  Future<void> resetPassword(String email) async {
    await _userRepository.resetPassword(email: email);
  }
}
