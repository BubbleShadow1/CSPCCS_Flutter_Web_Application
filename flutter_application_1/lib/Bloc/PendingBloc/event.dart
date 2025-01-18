// event.dart
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

  DepositEntryEvent(this.index);
}
