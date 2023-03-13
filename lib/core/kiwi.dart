import 'package:company_tasks/features/send_message/bloc.dart';
import 'package:kiwi/kiwi.dart';

void initKiwi() {
  final container = KiwiContainer();
  container.registerFactory((container) => SendMessageBloc());
}
