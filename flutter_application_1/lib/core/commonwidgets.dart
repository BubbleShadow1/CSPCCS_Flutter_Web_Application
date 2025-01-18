import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/bloc.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/event.dart';

class Commonwidgets {
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
