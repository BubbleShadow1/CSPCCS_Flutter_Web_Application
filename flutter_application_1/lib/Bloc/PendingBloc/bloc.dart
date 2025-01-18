import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  List<Map<String, dynamic>> entries = [];

  EntryBloc() : super(EntryInitialState()) {
    on<AddEntryEvent>((event, emit) {
      entries.add(event.entry);
      emit(EntryUpdatedState(List.from(entries)));
    });

    on<RemoveEntryEvent>((event, emit) {
      entries.removeAt(event.index);
      emit(EntryUpdatedState(List.from(entries)));
    });

    on<DepositEntryEvent>((event, emit) {
      // Handle deposit logic here if needed.
      emit(EntryUpdatedState(List.from(entries)));
    });
  }
}
