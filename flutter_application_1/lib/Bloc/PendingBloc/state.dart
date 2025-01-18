// state.dart
abstract class EntryState {}

class EntryInitialState extends EntryState {}

class EntryUpdatedState extends EntryState {
  final List<Map<String, dynamic>> entries;

  EntryUpdatedState(this.entries);
}
