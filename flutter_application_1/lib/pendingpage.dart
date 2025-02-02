import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/bloc.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/event.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pendingpage extends StatefulWidget {
  final EntryBloc bloc;

  const Pendingpage({super.key, required this.bloc});

  @override
  State<Pendingpage> createState() => _PendingpageState();
}

class _PendingpageState extends State<Pendingpage> {
  int ten10 = 0;
  int twenty20 = 0;
  int fifty50 = 0;
  int hundred100 = 0;
  int twohundred200 = 0;
  int fivehundred500 = 0;
  String remark = "";
  String recieptno = "";
  int totalMoney = 0;
  int totalNotes = 0;
  List<Map<String, dynamic>> entry = [];

  @override
  void initState() {
    super.initState();
    _getEntries();
  }

  Future<void> _getEntries() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? jsonList = pref.getStringList('entries');
    if (jsonList == null) entry=[];
    entry = jsonList
        !.map((jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entries'),
      ),
      body: BlocBuilder<EntryBloc, EntryState>(
        bloc: widget.bloc,
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
                            widget.bloc.add(RemoveEntryEvent(index));
                          },
                        ),
                      IconButton(
  icon: const Icon(Icons.attach_money, color: Colors.green),
  onPressed: () {
    final entryData = entries[index];

    final ten = entryData['ten'] ?? 0;
    final twenty = entryData['twenty'] ?? 0;
    final fifty = entryData['fifty'] ?? 0;
    final hundred = entryData['hundred'] ?? 0;
    final twoHundred = entryData['twoHundred'] ?? 0;
    final fiveHundred = entryData['fiveHundred'] ?? 0;
    final remark = entryData['remark'] ?? '';

    widget.bloc.add(DepositEntryEvent(
      index,
      context,
      true, // Deposit
      ten,
      twenty,
      fifty,
      hundred,
      twoHundred,
      fiveHundred,
      remark,
    ));
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
        onPressed: () => showAddEntryDialog(context, widget.bloc),
        child: const Icon(Icons.add),
      ),
    );
  }



void showAddEntryDialog(BuildContext context, EntryBloc bloc) {
  final TextEditingController tenController = TextEditingController();
  final TextEditingController twentyController = TextEditingController();
  final TextEditingController fiftyController = TextEditingController();
  final TextEditingController hundredController = TextEditingController();
  final TextEditingController twoHundredController = TextEditingController();
  final TextEditingController fiveHundredController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Entry'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              buildNumberField('10 Notes', tenController),
              buildNumberField('20 Notes', twentyController),
              buildNumberField('50 Notes', fiftyController),
              buildNumberField('100 Notes', hundredController),
              buildNumberField('200 Notes', twoHundredController),
              buildNumberField('500 Notes', fiveHundredController),
              buildStringField('Remark', remarkController),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (!(tenController.text.toString().isEmpty &&
                  twentyController.text.isEmpty &&
                  fiftyController.text.isEmpty &&
                  hundredController.text.isEmpty &&
                  twoHundredController.text.isEmpty &&
                  fiveHundredController.text.isEmpty)) {
                    
ten10 = _parseNumber(tenController.text);
  twenty20 = _parseNumber(twentyController.text);
  fifty50 = _parseNumber(fiftyController.text);
hundred100 = _parseNumber(hundredController.text);
twohundred200 = _parseNumber(twoHundredController.text);
  fivehundred500 = _parseNumber(fiveHundredController.text);
   remark = _parseString(remarkController.text);


                final entry = {
                  'ten': _parseNumber(tenController.text),
                  'twenty': _parseNumber(twentyController.text),
                  'fifty': _parseNumber(fiftyController.text),
                  'hundred': _parseNumber(hundredController.text),
                  'twoHundred': _parseNumber(twoHundredController.text),
                  'fiveHundred': _parseNumber(fiveHundredController.text),
                  'remark': _parseString(remarkController.text),
                };

                bloc.add(AddEntryEvent(entry));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

Widget buildNumberField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: label),
  );
}

Widget buildStringField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(labelText: label),
  );
}

int _parseNumber(String value) {
  if (value.isEmpty) return 0;
  return int.tryParse(value) ?? 0;
}

String _parseString(String value) {
  return value.trim();
}


}
