import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_idn_notes_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_idn_notes_app/data/models/request/register_request_model.dart';
import 'package:flutter_idn_notes_app/data/models/response/auth_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource remote;
  RegisterBloc(
    this.remote,
  ) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      final response  = await remote.register(event.data);
      response.fold(
        (error) => emit(RegisterFailed(message: error)),
        (data) => emit(RegisterSuccess(data: data)),
      );
    });
  }
}
