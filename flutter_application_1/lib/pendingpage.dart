import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/bloc.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/event.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/state.dart';
import 'package:flutter_application_1/core/commonwidgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pendingpage extends StatelessWidget {
  final EntryBloc bloc;

  const Pendingpage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entries'),
      ),
      body: BlocBuilder<EntryBloc, EntryState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is EntryUpdatedState) {
            final entries = state.entries;

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];

                return Card(
                  child: ListTile(
                    title: Text(entry['remark'].toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '10: ${entry['ten']}, 20: ${entry['twenty']}, 50: ${entry['fifty']}, 100: ${entry['hundred']}, 200: ${entry['twoHundred']}, 500: ${entry['fiveHundred']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            bloc.add(RemoveEntryEvent(index));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_money, color: Colors.green),
                          onPressed: () {
                            bloc.add(DepositEntryEvent(index));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No Entries'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Commonwidgets().showAddEntryDialog(context, bloc),
        child: const Icon(Icons.add),
      ),
    );
  }
}
