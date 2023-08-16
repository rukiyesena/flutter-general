import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzum_general/store/Customer/CustomerRepository.dart';
import 'package:uzum_general/store/Customer/Customer.dart';
import 'CustomerAction.dart';

class CustomerBloc extends Bloc<CustomerAction, Customer> {
  final CustomerRepository _customerStateRepository;

  CustomerBloc(this._customerStateRepository) : super(Customer());

  @override
  Stream<Customer> mapEventToState(
    CustomerAction event,
  ) async* {
    if (event is GetCustomer) {
      try {
        final weather = await _customerStateRepository.fetchCustomer(
            event.serviceAddress,
            event.customerId,
            event.customerName,
            event.plasiyer,
            event.printAddress,
            event.groupCode,
            event.token,
            event.additionalAuthority);
        print(event);
      } on NetworkException {
        print("nooooooooooooo");
      }
    }
  }
}
