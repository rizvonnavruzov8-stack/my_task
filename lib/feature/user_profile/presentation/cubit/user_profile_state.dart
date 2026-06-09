import 'package:equatable/equatable.dart';
import '../../data/user_model.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state when cubit is created
class UserProfileInitial extends UserProfileState {}

/// Loading state - user data is being fetched from repository
class UserProfileLoading extends UserProfileState {}

/// Loaded state - contains the user model from repository
class UserProfileLoaded extends UserProfileState {
  final User user;

  const UserProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Error state - contains error message
class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Saving state - user is being saved to repository
class UserProfileSaving extends UserProfileState {
  final User? previousUser;

  const UserProfileSaving({this.previousUser});

  @override
  List<Object?> get props => [previousUser];
}

/// Saved state - user was successfully saved (contains the saved user model)
class UserProfileSaved extends UserProfileState {
  final User user;

  const UserProfileSaved({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Deleting state - user is being deleted from repository
class UserProfileDeleting extends UserProfileState {}

/// Deleted state - user was successfully deleted
class UserProfileDeleted extends UserProfileState {}
