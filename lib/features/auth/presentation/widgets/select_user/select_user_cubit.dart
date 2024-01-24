import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectUserCubit extends Cubit<SelectUserState> {
  final AuthProvider provider;
  int _changedId = 0, _deletedId = 0;

  SelectUserCubit({required this.provider}) : super(SelectUserLoadingState()) {
    updateUsers();
    _changedId = provider.userChanged.subscribe((_) {
      updateUsers();
    });
    _deletedId = provider.userDeleted.subscribe((_) {
      updateUsers();
    });
  }

  @override
  Future close() async {
    await super.close();
    provider.userChanged.unsubscribe(_changedId);
    provider.userDeleted.unsubscribe(_deletedId);
  }

  void updateUsers() {
    emit(SelectUserLoadingState());
    provider.repository.getUsers().then((result) {
      result.match((users) => emit(SelectUserLoadedState(users: users)),
          (failure) => emit(SelectUserLoadingFailedState()));
    });
  }

  void deleteUser(UserId userId) {
    emit(SelectUserLoadingState());
    provider
        .deleteUser(userId)
        .then((value) => value.matchErr((_) => SelectUserLoadingFailedState()));
  }

  void selectUser(UserId userId) {
    emit(SelectUserLoadingState());
    provider.selectUser(userId).then((result) => result.match((_) {
          return emit(SelectUserSelectedState());
        }, (_) => emit(SelectUserLoadingFailedState())));
  }
}
