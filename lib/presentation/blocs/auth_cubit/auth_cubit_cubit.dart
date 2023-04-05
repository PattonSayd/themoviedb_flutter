import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit(AuthCubitState initialized) : super(initialized);
}
