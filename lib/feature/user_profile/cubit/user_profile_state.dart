import 'package:equatable/equatable.dart';
import '../data/user_model.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final User user;

  const UserProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class UserProfileSaving extends UserProfileState {}

class UserProfileSaved extends UserProfileState {
  final User user;

  const UserProfileSaved(this.user);
  
  @override
  List<Object> get props => [user];
}

class UserProfileDeleting extends UserProfileState {}

class UserProfileDeleted extends UserProfileState {}
