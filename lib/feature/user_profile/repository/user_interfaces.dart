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

/// Unified repository interface - the Cubit communicates with this
abstract class UserRepository implements UserReader, UserWriter, UserDeleter {
  @override
  Future<User> getUser();

  @override
  Future<void> saveUser(User user);

  @override
  Future<void> deleteUser(String id);
}
