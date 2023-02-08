import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/day_view.dart';
import 'package:eljur_students/features/schedule/presentation/widgets/days_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => locator<ScheduleBloc>(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleInitialState) {
                  BlocProvider.of<ScheduleBloc>(context)
                      .add(ReloadScheduleEvent());
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ScheduleLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ScheduleLoadErrorState) {
                  return const Center(child: Text('error'));
                } else if (state is ScheduleLoadedState) {
                  return DaysView(days: state.days);
                } else {
                  return Text('invalid state: ${state.runtimeType.toString()}');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
