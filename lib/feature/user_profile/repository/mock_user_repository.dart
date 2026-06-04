import '../data/user_model.dart';
import 'user_interfaces.dart';

class MockUserRepository implements UserReader, UserWriter, UserDeleter {
  User? _mockUser = const User(
    id: 'test',
    name: 'Test User',
    email: 'test@example.com',
    bio: 'Test Bio',
  );

  @override
  Future<User> getUser() async {
    if (_mockUser == null) throw Exception("User not found");
    return _mockUser!;
  }

  @override
  Future<void> saveUser(User user) async {
    _mockUser = user;
  }

  @override
  Future<void> deleteUser(String id) async {
    _mockUser = null;
  }
}
