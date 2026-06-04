import '../data/user_model.dart';

abstract class UserReader {
  Future<User> getUser();
}

abstract class UserWriter {
  Future<void> saveUser(User user);
}

abstract class UserDeleter {
  Future<void> deleteUser(String id);
}
