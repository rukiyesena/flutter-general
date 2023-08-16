import 'package:uzum_general/full-pages/login.dart';
import 'package:uzum_general/store/Customer/Customer.dart';

abstract class CustomerState {
  const CustomerState();
}

class CustomerInitial extends CustomerState {
  const CustomerInitial();
}

class CustomerLoading extends CustomerState {
  const CustomerLoading();
}

class CustomerLoaded extends CustomerState {
  final Customer login;
  const CustomerLoaded(this.login);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustomerLoaded && o.login == login;
  }

  @override
  int get hashCode => login.hashCode;
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustomerError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}