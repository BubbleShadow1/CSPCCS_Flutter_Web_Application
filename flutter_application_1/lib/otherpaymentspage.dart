import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/state.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/storedatabloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otherpaymentspage extends StatefulWidget {
  const Otherpaymentspage({super.key});

  @override
  State<Otherpaymentspage> createState() => _OtherpaymentspageState();
}

class _OtherpaymentspageState extends State<Otherpaymentspage> {
  Future<String?> user() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username;
  }

  final TextEditingController notes10Controller = TextEditingController();
  final TextEditingController notes20Controller = TextEditingController();
  final TextEditingController notes50Controller = TextEditingController();
  final TextEditingController notes100Controller = TextEditingController();
  final TextEditingController notes200Controller = TextEditingController();
  final TextEditingController notes500Controller = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController profitController = TextEditingController();
  final TextEditingController lossController = TextEditingController();
  final TextEditingController transactionProfitController =
      TextEditingController();
  final TextEditingController transactionLossController =
      TextEditingController();

  int profit = 0;
  int loss = 0;
  int totalMoney = 0;
  int totalNotes = 0;
  int recieptno = 0;
  int tenalreadystored = 0;
  int twentyalreadystored = 0;
  int fiftyalreadystored = 0;
  int hundredalreadystored = 0;
  int twohundredalreadystored = 0;
  int fivehundredalreadystored = 0;
  String remark = "";

  int _parseNumber(String value) =>
      value.isEmpty ? 0 : int.tryParse(value) ?? 0;

  Future<void> _updateTotals({required bool isDeposit}) async {
    final int notes10 = _parseNumber(notes10Controller.text);
    final int notes20 = _parseNumber(notes20Controller.text);
    final int notes50 = _parseNumber(notes50Controller.text);
    final int notes100 = _parseNumber(notes100Controller.text);
    final int notes200 = _parseNumber(notes200Controller.text);
    final int notes500 = _parseNumber(notes500Controller.text);

    int amount = notes10 * 10 +
        notes20 * 20 +
        notes50 * 50 +
        notes100 * 100 +
        notes200 * 200 +
        notes500 * 500;

    int totalnotes =
        notes10 + notes20 + notes50 + notes100 + notes200 + notes500;

    int profit1 = _parseNumber(transactionProfitController.text);
    int loss1 = _parseNumber(transactionLossController.text);

    final prefs = await SharedPreferences.getInstance();

    //  totalmoneyalreadystored =
    //     _parseNumber(prefs.getString('totalmoney') ?? '0');
    //  total = _parseNumber(prefs.getString('total') ?? '0');
    //  tenalreadystored = _parseNumber(prefs.getString('ten') ?? '0');
    //  twentyalreadystored = _parseNumber(prefs.getString('twenty') ?? '0');
    //  fiftyalreadystored = _parseNumber(prefs.getString('fifty') ?? '0');
    //  hundredalreadystored = _parseNumber(prefs.getString('hundred') ?? '0');
    //  twohundredalreadystored =
    //     _parseNumber(prefs.getString('twohundred') ?? '0');
    //  fivehundredalreadystored =
    //     _parseNumber(prefs.getString('fivehundred') ?? '0');

    // totalMoney = totalmoneyalreadystored;
    // totalNotes = total;

    // profit += _parseNumber(prefs.getString('profit') ?? '0');
    // loss -= _parseNumber(prefs.getString('loss') ?? '0');
    // recieptno += _parseNumber(prefs.getString('recieptno') ?? '0');
    recieptno++;

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    String formattedDateTime = formatter.format(now);

    setState(() async {
      String t = "";

      if (isDeposit) {
        profit += profit1;
        totalMoney += amount;
        totalNotes += totalnotes;
        tenalreadystored += notes10;
        twentyalreadystored += notes20;
        fiftyalreadystored += notes50;
        hundredalreadystored += notes100;
        twohundredalreadystored += notes200;
        fivehundredalreadystored += notes500;
        t = '\nDeposit:$recieptno\nTotal notes(w):500->$notes500|200->$notes200|100->$notes100|50->$notes50|20->$notes20|10->$notes10\nTotal Deposit Amount:$amount\nTotal Available Amount:$totalMoney\nTotal Available Notes:$totalNotes\nRemark:${remarkController.text.trim()}\nDate and Time:$formattedDateTime\n------------------------------\n';
      } else {
        loss += loss1;
        totalMoney -= amount;
        totalNotes -= totalnotes;
        tenalreadystored -= notes10;
        twentyalreadystored -= notes20;
        fiftyalreadystored -= notes50;
        hundredalreadystored -= notes100;
        twohundredalreadystored -= notes200;
        fivehundredalreadystored -= notes500;
        t = '\nWithdrawl:$recieptno\nTotal notes(w):500->$notes500|200->$notes200|100->$notes100|50->$notes50|20->$notes20|10->$notes10\nTotal Withdrawl Amount:$amount\nTotal Available Amount:$totalMoney\nTotal Available Notes:$totalNotes\nRemark:${remarkController.text.trim()} \nDate and Time:$formattedDateTime\n------------------------------\n';
      }

      final username = await user();
      final Depositrecord = prefs.getString('${username}login') ?? '';
      prefs.setString('${username}login', Depositrecord + t);
      remark += t;
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

      profitController.text = profit.toString();
      lossController.text = loss.toString();

      // Clear all input fields after transaction
      notes10Controller.clear();
      notes20Controller.clear();
      notes50Controller.clear();
      notes100Controller.clear();
      notes200Controller.clear();
      notes500Controller.clear();
      remarkController.clear();
      transactionProfitController.clear();
      transactionLossController.clear();

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
        'remark': remark,
        'loss': loss,
        'profit': profit,
        'createdAt': FieldValue.serverTimestamp(),
      };

      BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));
      BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());
    });
  }

  void clearlossorprofit(bool isprofit) {
    Map<String, dynamic> data = {};
    if (isprofit) {
 data = {
        'ten': tenalreadystored,
        'twenty': twentyalreadystored,
        'fifty': fiftyalreadystored,
        'hundred': hundredalreadystored,
        'twohundred': twohundredalreadystored,
        'fivehundred': fivehundredalreadystored,
        'total': totalNotes,
        'totalmoney': totalMoney,
        'recieptno': recieptno,
        'remark': remark,
        'loss': loss,
        'profit': 0,
        'createdAt': FieldValue.serverTimestamp(),
      };
    } else {
      data = {
        'ten': tenalreadystored,
        'twenty': twentyalreadystored,
        'fifty': fiftyalreadystored,
        'hundred': hundredalreadystored,
        'twohundred': twohundredalreadystored,
        'fivehundred': fivehundredalreadystored,
        'total': totalNotes,
        'totalmoney': totalMoney,
        'recieptno': recieptno,
        'remark': remark,
        'loss': 0,
        'profit': profit,
        'createdAt': FieldValue.serverTimestamp(),
      };
    }

    BlocProvider.of<FirebaseBloc>(context).add(AddDataEvent(data));
    BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());
  }

  void dataallocationFunc() async {
    BlocProvider.of<FirebaseBloc>(context).add(FetchUsersEvent());
  }

  @override
  void initState() {
    super.initState();
    dataallocationFunc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseBloc, FirebaseState>(
        listener: (context, state) {
          if (state is FirebaseLoading) {
          } else if (state is UsersFetchedState) {
            final data = state.users;

            if (data.isNotEmpty) {
              final user = data.last;
              setState(() {
                lossController.text = user['loss']?.toString() ?? '0';
                profitController.text = user['profit']?.toString() ?? '0';
                totalMoney = int.parse(user['totalmoney']?.toString() ?? '0');
                totalNotes = int.parse(user['total']?.toString() ?? '0');
                profit = int.parse(user['profit'].toString());
                loss = int.parse(user['loss'].toString());
                recieptno = int.parse(user['recieptno'].toString());

                tenalreadystored = int.parse(user['ten'].toString());
                twentyalreadystored = int.parse(user['twenty'].toString());
                fiftyalreadystored = int.parse(user['fifty'].toString());
                hundredalreadystored = int.parse(user['hundred'].toString());
                twohundredalreadystored =
                    int.parse(user['twohundred'].toString());
                fivehundredalreadystored =
                    int.parse(user['fivehundred'].toString());
                remark = user['remark'].toString();
              });
            }

            // ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            //   const SnackBar(content: Text("Data fetched successfully!")),
            // );
          } else if (state is FirebaseSuccess) {
            // ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            //   const SnackBar(content: Text("Data stored successfully!")),
            // );
          } else if (state is FirebaseError) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Other Payments Page"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildNumberField("10 Notes", notes10Controller),
                  _buildNumberField("20 Notes", notes20Controller),
                  _buildNumberField("50 Notes", notes50Controller),
                  _buildNumberField("100 Notes", notes100Controller),
                  _buildNumberField("200 Notes", notes200Controller),
                  _buildNumberField("500 Notes", notes500Controller),
                  _buildStringField("Remark", remarkController),
                  _buildNumberField("Profit in this Transaction",
                      transactionProfitController),
                  _buildNumberField(
                      "Loss in this Transaction", transactionLossController),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Profit:"),
                      Expanded(
                        child: _buildReadOnlyField(profitController),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Loss:"),
                      Expanded(
                        child: _buildReadOnlyField(lossController),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Money:"),
                      Text(totalMoney.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Notes:"),
                      Text(totalNotes.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _updateTotals(isDeposit: true),
                        child: const Text("Deposit"),
                      ),
                      ElevatedButton(
                        onPressed: () => _updateTotals(isDeposit: false),
                        child: const Text("Withdraw"),
                      ),
                      ElevatedButton(
                        onPressed: () => clearlossorprofit(false),
                        child: const Text("Clear Loss"),
                      ),
                      ElevatedButton(
                        onPressed: () =>clearlossorprofit(true),
                        child: const Text("Clear Profit"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildStringField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildReadOnlyField(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
