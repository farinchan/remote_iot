import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'relay_event.dart';
part 'relay_state.dart';

class RelayBloc extends Bloc<RelayEvent, RelayState> {
  RelayBloc() : super(RelayInitial()) {
    on<RelayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
