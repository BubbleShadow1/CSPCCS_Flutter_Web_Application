import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/PendingBloc/bloc.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pendingpage.dart';

class HomePage extends StatefulWidget {
  final int ten;
  final int twenty;
  final int fifty;
  final int hundred;
  final int twohundred;
  final int fivehundred;
  final int totalmoney;
  final int total;
  final int recieptno;

  const HomePage({
    Key? key,
    required this.ten,
    required this.twenty,
    required this.fifty,
    required this.hundred,
    required this.twohundred,
    required this.fivehundred,
    required this.totalmoney,
    required this.total,
    required this.recieptno,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Define the pages for the BottomNavigationBar

    _pages = [
      MainApp(
        ten: widget.ten,
        twenty: widget.twenty,
        fifty: widget.fifty,
        hundred: widget.hundred,
        twohundred: widget.twohundred,
        fivehundred: widget.fivehundred,
        totalmoney: widget.totalmoney,
        total: widget.total,
        recieptno: widget.recieptno,
      ),
     Pendingpage(bloc: EntryBloc()), 
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main App',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pending List',
          ),
        ],
      ),
    );
  }
}
