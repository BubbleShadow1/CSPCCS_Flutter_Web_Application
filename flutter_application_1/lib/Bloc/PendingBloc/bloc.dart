import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/event.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/state.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/storedatabloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  List<Map<String, dynamic>> entries = [];

  EntryBloc() : super(EntryInitialState()) {
   
    _initializeEntries();

    on<AddEntryEvent>((event, emit) async {
      entries.add(event.entry);
      await _saveEntries();
      emit(EntryUpdatedState(List.from(entries)));
    });

    on<RemoveEntryEvent>((event, emit) async {
      entries.removeAt(event.index);
      await _saveEntries();
      emit(EntryUpdatedState(List.from(entries)));
    });

 on<DepositEntryEvent>((event, emit) async {
  final entry = entries[event.index];

  entry['ten'] += event.notes10;
  entry['twenty'] += event.notes20;
  entry['fifty'] += event.notes50;
  entry['hundred'] += event.notes100;
  entry['twoHundred'] += event.notes200;
  entry['fiveHundred'] += event.notes500;

  entry['totalMoney'] = (entry['totalMoney'] ?? 0) +
      (event.notes10 * 10 +
          event.notes20 * 20 +
          event.notes50 * 50 +
          event.notes100 * 100 +
          event.notes200 * 200 +
          event.notes500 * 500);

  entry['totalNotes'] = (entry['totalNotes'] ?? 0) +
      (event.notes10 +
          event.notes20 +
          event.notes50 +
          event.notes100 +
          event.notes200 +
          event.notes500);

  // Save updated list
  entries[event.index] = entry;
  await _saveEntries();

  // Update Firestore
  await _updateTotals(
    context: event.context,
    isDeposit: event.isDeposit,
    notes10: event.notes10,
    notes20: event.notes20,
    notes50: event.notes50,
    notes100: event.notes100,
    notes200: event.notes200,
    notes500: event.notes500,
    remark: event.remark,
  );
   entries.removeAt(event.index);
  emit(EntryUpdatedState(List.from(entries)));

});

  }

  Future<void> _initializeEntries() async {
    entries = await _getEntries();
    emit(EntryUpdatedState(List.from(entries)));
  }

  Future<void> _saveEntries() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> jsonList = entries.map((entry) => jsonEncode(entry)).toList();
    await pref.setStringList('entries', jsonList);
  }

  Future<List<Map<String, dynamic>>> _getEntries() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? jsonList = pref.getStringList('entries');
    if (jsonList == null) return [];
    return jsonList
        .map((jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>)
        .toList();
  }

  int _parseNumber(String value) =>
      value.isEmpty ? 0 : int.tryParse(value) ?? 0;

  Future<void> _updateTotals(
      {required BuildContext context,
      required bool isDeposit,
      required int notes10,
      required int notes20,
      required int notes50,
      required int notes100,
      required int notes200,
      required int notes500,
      required String remark,
      int? profit = 0,
      int? loss = 0}) async {
    int totalMoney;
    int totalNotes;
    int amount = notes10 * 10 +
        notes20 * 20 +
        notes50 * 50 +
        notes100 * 100 +
        notes200 * 200 +
        notes500 * 500;

    int totalnotes =
        notes10 + notes20 + notes50 + notes100 + notes200 + notes500;

    int profit1 = profit ?? 0;
    int loss1 = loss ?? 0;

    final prefs = await SharedPreferences.getInstance();
    int totalmoneyalreadystored = int.parse(prefs.getString('totalmoney')!);
    int total = int.parse(prefs.getString('total')!);
    int tenalreadystored = int.parse(prefs.getString('ten')!);
    int twentyalreadystored = int.parse(prefs.getString('twenty')!);
    int fiftyalreadystored = int.parse(prefs.getString('fifty')!);
    int hundredalreadystored = int.parse(prefs.getString('hundred')!);
    int twohundredalreadystored = int.parse(prefs.getString('twohundred')!);
    int fivehundredalreadystored = int.parse(prefs.getString('fivehundred')!);

    totalMoney = totalmoneyalreadystored;
    totalNotes = total;

    String profitfromprefs = prefs.getString('profit') ?? '0';
    String lossfromprefs = prefs.getString('loss') ?? '0';
    int recieptno = int.parse(prefs.getString('recieptno')!);
    recieptno++;

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    String formattedDateTime = formatter.format(now);

    profit = int.parse(profitfromprefs) + profit1;
    loss = int.parse(lossfromprefs) + loss1;

    String t = "";

    if (isDeposit) {
      totalMoney += amount;
      totalNotes += totalnotes;
      tenalreadystored += notes10;
      twentyalreadystored += notes20;
      fiftyalreadystored += notes50;
      hundredalreadystored += notes100;
      twohundredalreadystored += notes200;
      fivehundredalreadystored += notes500;
      t = '\nDeposit:$recieptno\nTotal notes(w):500->$notes500|200->$notes200|100->$notes100|50->$notes50|20->$notes20|10->$notes10\nTotal Deposit Amount:$amount\nTotal Available Amount:$totalMoney\nTotal Available Notes:$totalNotes\nRemark:$remark\nDate and Time:$formattedDateTime\n------------------------------\n';
    }

    final username = await user();
    final Depositrecord = prefs.getString('${username}login');
    String tt = Depositrecord.toString() + t;
    prefs.setString('${username}login', tt);

//setting in the shared preference and  update the value from shared preference .

    prefs.setString('profit', profit.toString());
    prefs.setString('loss', loss.toString());
    prefs.setString('totalmoney', totalMoney.toString());
    prefs.setString('totalnotes', totalNotes.toString());
    prefs.setString('ten', tenalreadystored.toString());
    prefs.setString('twenty', twentyalreadystored.toString());
    prefs.setString('fifty', fiftyalreadystored.toString());
    prefs.setString('hundred', hundredalreadystored.toString());
    prefs.setString('twohundred', twohundredalreadystored.toString());
    prefs.setString('fivehundred', fivehundredalreadystored.toString());
    prefs.setString('recieptno', recieptno.toString());

    Map<String, dynamic> data = {
      'ten': tenalreadystored,
      'twenty': twentyalreadystored,
      'fifty': fiftyalreadystored,
      'hundred': hundredalreadystored,
      'twohundred': twohundredalreadystored,
      'fivehundred': fivehundredalreadystored,
      'total': totalNotes,
      'totalmoney': totalMoney,
      'recieptno': recieptno,
      'remark': tt,
      'loss': loss,
      'profit': profit,
      'createdAt': FieldValue.serverTimestamp(),
    };

    BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));
  }

  Future<String?> user() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username;
  }
}
