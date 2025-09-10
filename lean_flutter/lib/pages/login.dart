import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lean_flutter/config/config.dart';
import 'package:lean_flutter/config/internal_config.dart';
import 'package:lean_flutter/model/request/customer_login_post_req.dart';
import 'package:lean_flutter/model/response/customer_login_post_res.dart';
import 'package:lean_flutter/pages/RegisterPage.dart';
import 'package:lean_flutter/pages/ShowTropPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int number = 0;
  String phoneNum = '';
  var phoneCtl = TextEditingController();
  var passwordCtl = TextEditingController();

  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login Page')),
      // body: Column(
      //   // mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       "Hello world",
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.red,
      //       ),
      //     ),
      //     TextField(
      //       decoration: InputDecoration(
      //         border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
      //       ),
      //     ),

      //     Expanded(
      //       child: ListView(
      //         children: [
      //           ElevatedButton(onPressed: () {}, child: Text("okay")),
      //           OutlinedButton(onPressed: () {}, child: Text("okay")),
      //           Image.network(
      //             'https://imgs.search.brave.com/JA600XIu9UFi0RHPvb5C7kGP0YXPDp9dJSzTPBvSVoU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMzLmFscGhhY29k/ZXJzLmNvbS8xMzYv/dGh1bWJiaWctMTM2/Mjc0NS53ZWJw',
      //           ),
      //           Image.asset('assets/images/1105991.jpg'),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      appBar: AppBar(title: const Text('Login Page')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () => login(),
                  child: Image.asset('assets/images/ff.jpg'),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 30,
                    left: 30,
                    top: 30,
                  ),
                  child: Text(
                    "หมายเลขโทรศัพท์",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 30,
                    left: 30,
                    bottom: 30,
                  ),
                  child: TextField(
                    controller: phoneCtl,
                    keyboardType: TextInputType.numberWithOptions(),
                    // onChanged: (value) {
                    //   log(value);
                    //   value = phoneNum;
                    // },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(right: 30, left: 30),
                  child: Text(
                    "รหัสผ่าน",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 30,
                    left: 30,
                    bottom: 30,
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: passwordCtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: register,
                          child: const Text('ลงทะเบียน'),
                        ),
                        FilledButton(
                          onPressed: login,
                          child: const Text('เข้าสูระบบ'),
                        ),
                      ],
                    ),
                    Text(text, style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registerpage()),
    );
  }

  //prosage
  // void login() {
  // log(phoneCtl.text);
  // log(passwordCtl.text);
  // if (phoneCtl.text == "111" && passwordCtl == "1234") {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Showtroppage()),
  //   );
  // } else {
  //   setState(() {
  //     text = 'phone no or password incorrect';
  //   });
  // }
  // }
  void login() {
    // var data = {"phone": "0817399999", "password": "1111"};
    CustomerLoginPostRequest req = CustomerLoginPostRequest(
      phone: phoneCtl.text,
      password: passwordCtl.text,
      // phone: "0817399999",
      // password: "1111",
    );
    http
        .post(
          Uri.parse("$api_Endpoint/customers/login"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: customerLoginPostRequestToJson(req),
        )
        .then((value) {
          CustomerLoginPostResponse customerLoginPostResponse =
              customerLoginPostResponseFromJson(value.body);
          log(customerLoginPostResponse.customer.fullname);
          log(customerLoginPostResponse.customer.email);
          log(customerLoginPostResponse.customer.idx.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Showtroppage(cid: customerLoginPostResponse.customer.idx),
            ),
          );
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
