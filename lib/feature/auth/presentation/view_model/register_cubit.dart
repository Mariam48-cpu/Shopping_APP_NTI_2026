import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/register_state.dart';
import '../../domain/entities/register_request_entity.dart';
import '../../domain/use_case/register_use_case.dart';
@injectable
class  RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

 final RegisterUseCase _registerUseCase;

Future<void>intent(RegisterIntent intent)async{
  switch(intent) {
    case RegisterIntentRegister():
      _register(intent.request);

  }
}
Future<void>_register(RegisterRequestEntity request)async{
  emit(RegisterLoading());
  var result=await _registerUseCase.invoke(request);
  switch(result) {
    case Success<String>():
      emit(RegisterSuccess());

    case Error<String>():
      emit(RegisterError(result.messageError));
  }

}
}



sealed class RegisterIntent{}

class RegisterIntentRegister extends RegisterIntent{
  final RegisterRequestEntity request;
  RegisterIntentRegister({required this.request});
}
