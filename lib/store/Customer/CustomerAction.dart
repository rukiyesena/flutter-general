import 'package:flutter/cupertino.dart';

@immutable
abstract class CustomerAction {}

class GetCustomer extends CustomerAction {
  final String serviceAddress = "";
  final String customerId = "";
  final String customerName = "";
  final String plasiyer = "";
  final String printAddress = "";
  final String groupCode = "";
  final String token = "";
  final String additionalAuthority = "";

  GetCustomer(serviceAddress, customerId, customerName, plasiyer, printAddress,
      groupCode, token, additionalAuthority);
}
