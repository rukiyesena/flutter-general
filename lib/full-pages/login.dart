import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:uzum_general/store/Customer/CustomerAction.dart';
import 'package:uzum_general/store/Customer/CustomerBlock.dart';
import 'package:uzum_general/store/Customer/Customer.dart';
import 'package:uzum_general/store/Customer/CustomerState.dart';
import 'package:uzum_general/store/Login/LoginCubit.dart';
import 'package:xml/xml.dart';
import 'package:uzum_general/theme-config/Theme.dart';
import 'package:uzum_general/models/UserModel.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _companycodeController = TextEditingController();
  var client = IOClient();

  bool rememberpwd = false;
  bool sec = true;
  bool _isLoading = false;
  bool _isChecked = false;

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  var visable = Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  BlocBuilder<LoginCubit, CustomerState>(
                    builder: (context, state) {
                      return buildInitialInput();
                    },
                  ),
                  Container(
                    //color: Colors.white,

                    decoration: BoxDecoration(color: NowUIColors.logoColor),
                  ),
                  SafeArea(
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 24.0, right: 24.0, bottom: 0),
                        child: Card(
                            color: Colors.black.withOpacity(0.0),
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    color: Colors.black.withOpacity(0.2),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/login.09ffa508.png",
                                                        height: 100,
                                                        fit: BoxFit.fill),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 15),
                                                  child: Column(
                                                    children: [
                                                      buildCompanyCode(),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      buildEmail(),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      buildPassword(),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      buildRememberassword(),
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(NowUIColors
                                                                      .socialFacebook),
                                                        ),
                                                        onPressed: () =>
                                                            submitCityName(
                                                                context),
                                                        child: const Text(
                                                            'Gönder'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: Center(),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    buildMail(),
                                                    //buildFacebook(),
                                                    // buildGoogle(),
                                                    // buildTwitter()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            )),
                      ),
                    ]),
                  )
                ],
              ),
      ),
    );
  }

  Widget buildCompanyCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey),
              color: Colors.black.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextField(
            controller: _companycodeController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(left: 5),
                prefixIcon: Icon(Icons.person, color: Colors.white, size: 15.0),
                hintText: 'Firma Kodu',
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey),
              color: Colors.black.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(left: 5),
                prefixIcon: Icon(Icons.person, color: Colors.white, size: 15.0),
                hintText: 'Kullanıcı Adı',
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  void submitCityName(BuildContext context) {
    var userName = _usernameController.text;
    var userCompanyId = _companycodeController.text;
    var userPassword = _passwordController.text;
    var loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.getLoginInformation(userCompanyId, userName, userPassword);
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
            color: Colors.black.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 40,
          child: TextField(
            controller: _passwordController,
            obscureText: sec,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                /*   enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: NowUIColors.primary, width: 0.0),
                ),
                border: const OutlineInputBorder(),*/
                labelStyle: new TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.vpn_key, color: Colors.white, size: 15.0),
                hintText: "Şifre",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget buildRememberassword() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: NowUIColors.white),
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: NowUIColors.primary,
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                    _handleRemeberme(_isChecked);
                  });
                },
              )),
          Text(
            "Beni Hatırla",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: NowUIColors.white),
          ),
        ],
      ),
    );
  }

  Widget buildInitialInput() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => launch(""),
        label: Text("",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: NowUIColors.white,
            )),
        icon: Icon(
          Icons.phone,
          color: NowUIColors.white,
        ),
      ),
    );
  }

  Widget buildMail() {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => launch("mailto:"),
        label: Text("",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: NowUIColors.white,
            )),
        icon: Icon(
          Icons.mail,
          color: NowUIColors.white,
        ),
      ),
    );
  }

  _loginControl() async {
    var username = _usernameController.text;
    var companycode = _companycodeController.text;
    var password = _passwordController.text;

    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/">
  <soap:Body>
    <loginService xmlns="http://schemas.xmlsoap.org/wsdl/">
      <companyId>$companycode</companyId>
      <userName>$username</userName>
      <password>$password</password>
    </loginService>
  </soap:Body>
</soap:Envelope>
''';
    var envelope2 = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <kullaniciGirisiOnline xmlns="http://tempuri.org/">
      <firmaKodu>$companycode</firmaKodu>
      <userName>$username</userName>
      <password>$password</password>
    </kullaniciGirisiOnline>
  </soap:Body>
</soap:Envelope>
''';

    var request = http.Request(
      'POST',
      Uri.parse('http://www.service.uzum.com.tr/loginService.php'),
    );
    request.headers.addAll({'content-type': 'text/xml; charset=utf-8'});
    /*  request.bodyFields = {
      'companyId': companycode,
      'userName': username
      'password': password
    };*/

    request.body = envelope;
    var streamedResponse = await client.send(request);
    var responseBody =
        await streamedResponse.stream.transform(utf8.decoder).join();
    final parsedXml = XmlDocument.parse(responseBody);
    final textual = parsedXml.descendants
        .where((node) => node is XmlText && node.text.trim().isNotEmpty)
        .join('\n');
    final result = jsonDecode(textual);
    print(result);

    //  print(result[0]['printAddress']);
    var url = result[0]['servisAdresi'];

    if (streamedResponse.statusCode == 200) {
      var request2 = http.Request(
        'POST',
        Uri.parse(url),
      );
      request2.headers.addAll({'content-type': 'text/xml; charset=utf-8'});

      request2.body = envelope2;
      var streamedResponse2 = await client.send(request2);
      print(streamedResponse2.statusCode);
      if (streamedResponse2.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        var responseBody =
            await streamedResponse2.stream.transform(utf8.decoder).join();
        final parsedXml2 = XmlDocument.parse(responseBody);
        final textual2 = parsedXml2.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');
        final result2 = jsonDecode(textual2);
        print(result2[0]['tokenId']);

        //usermodeldeki login metodunu çalıştırır
        Provider.of<UserModel>(context, listen: false)
            .login(_usernameController.text, result2[0]['tokenId']);
        Navigator.pop(context);

        setState(() {
          _isLoading = false;
          sharedPreferences.setString("access_token", result2[0]['tokenId']);
          /*  Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Kit()),
                  (Route<dynamic> route) => false);*/
        });
      }
    }

    /*   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('http://proje.eofyazilim.com:35019/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'username': username,
      'password': password
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var response2 = await http.Response.fromStream(response);
      final result = jsonDecode(response2.body) as Map<String, dynamic>;
      jsonData = result['access_token'];

      //usermodeldeki login metodunu çalıştırır
      Provider.of<UserModel>(context, listen: false)
          .login(_usernameController.text, jsonData);
      Navigator.pop(context);

      setState(() {
        _isLoading = false;
        sharedPreferences.setString("access_token", jsonData);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Kit()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.reasonPhrase);
    }*/
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void Notify() async {
    // local notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            bigPicture: 'assets://images/protocoderlogo.png'));
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('username', _usernameController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("username") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _usernameController.text = _username;
        _passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }
}
