import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_pro/logic/providers/app_state_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  ConsumerState<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final appStateNotifier = ref.read(appStateProvider.notifier);
    return Scaffold(
      body: appState.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final todo = data[index];
              return ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: todo.isDone,
                      onChanged: (bool? newValue) {
                        appStateNotifier.toggleStatus(todo);
                      },
                    ),
                    Text(data[index].title),
                  ],
                ),
              );
            },
          );
        },
        error: (error, st) => ErrorWidget(error),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
