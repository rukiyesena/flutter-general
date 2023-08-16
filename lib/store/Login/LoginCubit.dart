import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:uzum_general/store/Customer/CustomerBlock.dart';
import 'package:uzum_general/store/Customer/CustomerState.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzum_general/store/Customer/CustomerRepository.dart';
import 'package:uzum_general/store/Customer/Customer.dart';

class LoginCubit extends Cubit<CustomerState> {
  final CustomerRepository _customerRepository;
  var client = IOClient();
  var result2;
  LoginCubit(this._customerRepository) : super(CustomerInitial());

  Future<void> getLoginInformation(
      String userCompanyId, String userName, String userPassword) async {
    try {
      var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/">
  <soap:Body>
    <loginService xmlns="http://schemas.xmlsoap.org/wsdl/">
      <companyId>$userCompanyId</companyId>
      <userName>$userName</userName>
      <password>$userPassword</password>
    </loginService>
  </soap:Body>
</soap:Envelope>
''';
      var envelope2 = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <kullaniciGirisiOnline xmlns="http://tempuri.org/">
      <firmaKodu>$userCompanyId</firmaKodu>
      <userName>$userName</userName>
      <password>$userPassword</password>
    </kullaniciGirisiOnline>
  </soap:Body>
</soap:Envelope>
''';

      var request = http.Request(
        'POST',
        Uri.parse('http://www.service.uzum.com.tr/loginService.php'),
      );
      request.headers.addAll({'content-type': 'text/xml; charset=utf-8'});
      request.body = envelope;
      var streamedResponse = await client.send(request);
      var responseBody =
          await streamedResponse.stream.transform(utf8.decoder).join();
      final parsedXml = XmlDocument.parse(responseBody);
      final textual = parsedXml.descendants
          .where((node) => node is XmlText && node.text.trim().isNotEmpty)
          .join('\n');
      final result = jsonDecode(textual);

      //  print(result[0]['printAddress']);
      var url = result[0]['servisAdresi'];
      print(result[0]);

      if (streamedResponse.statusCode == 200) {
        var request2 = http.Request(
          'POST',
          Uri.parse(url),
        );
        request2.headers.addAll({'content-type': 'text/xml; charset=utf-8'});

        request2.body = envelope2;
        var streamedResponse2 = await client.send(request2);

        if (streamedResponse2.statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          var responseBody =
              await streamedResponse2.stream.transform(utf8.decoder).join();
          final parsedXml2 = XmlDocument.parse(responseBody);
          final textual2 = parsedXml2.descendants
              .where((node) => node is XmlText && node.text.trim().isNotEmpty)
              .join('\n');
          result2 = jsonDecode(textual2);
          print(result2[0]['tokenId']);

          //usermodeldeki login metodunu çalıştırır
          /*  Provider.of<UserModel>(context, listen: false)
            .login(_usernameController.text, result2[0]['tokenId']);
        Navigator.pop(context);*/

        }
      }
      print(result2);
      final weather = await _customerRepository.fetchCustomer(
          result[0]['servisAdresi'],
          result[0]['id'],
          result[0]['adSoyad'],
          result2[0]['plasiyer'],
          result[0]['printAddress'],
          result[0]['grupKod'],
          result2[0]['tokenId'],
          result[0]['ekYetkiler']);

      final bloc = CustomerBloc(_customerRepository);
      final currentState = bloc.state;
      emit(CustomerLoaded(weather));
      print("vaaaa");
      print(currentState);
      print(bloc);
      
    } on NetworkException {
      print("nooo");
    }
  }
}
