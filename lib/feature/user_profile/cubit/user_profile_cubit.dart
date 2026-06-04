import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/user_model.dart';
import '../repository/user_interfaces.dart';
import 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserReader reader;
  final UserWriter writer;
  final UserDeleter deleter;

  UserProfileCubit({
    required this.reader,
    required this.writer,
    required this.deleter,
  }) : super(UserProfileInitial());

  Future<void> loadUser() async {
    emit(UserProfileLoading());
    try {
      final user = await reader.getUser();
      emit(UserProfileLoaded(user));
    } catch (e) {
      emit(UserProfileError('Failed to load user: $e'));
    }
  }

  Future<void> saveUser(User user) async {
    emit(UserProfileSaving());
    try {
      await writer.saveUser(user);
      emit(UserProfileSaved(user));
      emit(UserProfileLoaded(user)); 
    } catch (e) {
      emit(UserProfileError('Failed to save user: $e'));
    }
  }

  Future<void> deleteUser(String id) async {
    emit(UserProfileDeleting());
    try {
      await deleter.deleteUser(id);
      emit(UserProfileDeleted());
    } catch (e) {
      emit(UserProfileError('Failed to delete user: $e'));
    }
  }
}