import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/user_model.dart';
import '../../repository/user_interfaces.dart';
import 'user_profile_state.dart';

/// UserProfileCubit acts as a communicator between the Repository and UI States
/// - Receives entities from the repository
/// - Saves models in states for effective UI control
class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository repository;

  UserProfileCubit({required this.repository}) : super(UserProfileInitial());

  /// Load user from repository and emit loaded state with user model
  Future<void> loadUser() async {
    emit(UserProfileLoading());
    try {
      final user = await repository.getUser();
      // Emit state with user model - this allows UI to control state based on model
      emit(UserProfileLoaded(user: user));
    } catch (e) {
      emit(UserProfileError(message: 'Failed to load user: $e'));
    }
  }

  /// Save user to repository and emit appropriate states
  Future<void> saveUser(User user) async {
    emit(
      UserProfileSaving(
        previousUser: state is UserProfileLoaded
            ? (state as UserProfileLoaded).user
            : null,
      ),
    );
    try {
      await repository.saveUser(user);
      // Emit saved state with the updated user model
      emit(UserProfileSaved(user: user));
      // Then emit loaded state to show updated data in UI
      await Future.delayed(const Duration(milliseconds: 500));
      emit(UserProfileLoaded(user: user));
    } catch (e) {
      emit(UserProfileError(message: 'Failed to save user: $e'));
    }
  }

  /// Delete user from repository and emit appropriate states
  Future<void> deleteUser(String id) async {
    emit(UserProfileDeleting());
    try {
      await repository.deleteUser(id);
      // Emit deleted state indicating successful deletion
      emit(UserProfileDeleted());
    } catch (e) {
      emit(UserProfileError(message: 'Failed to delete user: $e'));
    }
  }
}
