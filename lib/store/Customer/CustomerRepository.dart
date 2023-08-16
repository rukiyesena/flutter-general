import 'Customer.dart';

abstract class LoginRepository {
  Future<Customer> fetchCustomer(
      String serviceAddress,
      String customerId,
      String customerName,
      String plasiyer,
      String printAddress,
      String groupCode,
      String token,
      String additionalAuthority);
}

class CustomerRepository implements LoginRepository {
  @override
  Future<Customer> fetchCustomer(
      String serviceAddress,
      String customerId,
      String customerName,
      String plasiyer,
      String printAddress,
      String groupCode,
      String token,
      String additionalAuthority) async {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Customer(
            serviceAddress: serviceAddress,
            customerId: customerId,
            customerName: customerName,
            plasiyer: plasiyer,
            printAddress: printAddress,
            groupCode: groupCode,
            token: token,
            additionalAuthority: additionalAuthority);
      },
    );
  }
}

class NetworkException implements Exception {}
