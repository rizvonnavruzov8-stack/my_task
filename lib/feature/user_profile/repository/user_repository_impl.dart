import '../data/user_model.dart';
import 'user_interfaces.dart';

class UserRepositoryImpl implements UserReader, UserWriter, UserDeleter {
  @override
  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return const User(
      id: '1',
      name: 'Rizvon Navruzovo',
      email: 'rizvon@gmail.com',
      bio: 'Student of UCA',
    );
  }

  @override
  Future<void> saveUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate successful save
  }

  @override
  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate successful deletion
  }
}
