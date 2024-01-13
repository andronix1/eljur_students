import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/di.dart';
import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_cubit.dart';
import 'package:eljur_students/features/auth/presentation/widgets/select_user/select_user_state.dart';
import 'package:eljur_students/features/auth/presentation/widgets/user_card.dart';
import 'package:eljur_students/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectUserWidget extends StatelessWidget {
  const SelectUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocProvider(
        create: (_) => getIt<SelectUserCubit>(),
        child: BlocConsumer<SelectUserCubit, SelectUserState>(
          builder: (context, state) => switch (state) {
            SelectUserLoadingState() =>
              const Center(child: CircularProgressIndicator()),
            SelectUserLoadingFailedState() => const Text("failed to load"),
            SelectUserLoadedState(users: var users) => users.isEmpty
                ? const Center(child: Text("нет сохранённых пользователей :("))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (context, id) {
                      var user = users[id];
                      return UserCard(
                        name:
                            '${user.userInfo.middleName} ${user.userInfo.firstName}',
                        onDelete: () =>
                            BlocProvider.of<SelectUserCubit>(context)
                                .deleteUser(user.userInfo.userId),
                        onSelect: () =>
                            BlocProvider.of<SelectUserCubit>(context)
                                .selectUser(user.userInfo.userId),
                      );
                    },
                  ),
            SelectUserSelectedState() =>
              const Center(child: CircularProgressIndicator()),
          },
          listener: (context, state) {
            if (state is SelectUserSelectedState) {
              context.navigateTo(MainAppRoute());
            }
          },
        ),
      ),
    );
  }
}
