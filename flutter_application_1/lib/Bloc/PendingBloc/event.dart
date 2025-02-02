// event.dart
import 'package:flutter/material.dart';

abstract class EntryEvent {}

class AddEntryEvent extends EntryEvent {
  final Map<String, dynamic> entry;

  AddEntryEvent(this.entry);
}

class RemoveEntryEvent extends EntryEvent {
  final int index;

  RemoveEntryEvent(this.index);
}

class DepositEntryEvent extends EntryEvent {
  final int index;
  BuildContext context;
  bool isDeposit;
  int notes10;
  int notes20;
  int notes50;
  int notes100;
  int notes200;
  int notes500;
  String remark;

  DepositEntryEvent(this.index,this.context,this.isDeposit,this.notes10,this.notes20,this.notes50,this.notes100,this.notes200,this.notes500,this.remark);

}
