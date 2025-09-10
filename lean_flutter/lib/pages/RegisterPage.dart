import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lean_flutter/model/request/customer_login_post_req.dart';
import 'package:lean_flutter/model/request/customer_register_post_res.dart';

import 'package:lean_flutter/model/response/customer_register_post_req.dart';
import 'package:lean_flutter/pages/ShowTropPage.dart';
import 'package:lean_flutter/pages/login.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterState();
}

class _RegisterState extends State<Registerpage> {
  String text = '';
  var nameCtl = TextEditingController();
  var phoneCtl = TextEditingController();
  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var confimpasswordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ลงทะเบียน')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: 30,
                    left: 30,
                    bottom: 10,
                  ),
                  child: Text(
                    "ชื่อ-นามสกุล",
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
                    controller: nameCtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 30, bottom: 10),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 30, bottom: 10),
                  child: Text(
                    "อีเมล",
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
                    controller: emailCtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 30, bottom: 10),
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
                    controller: passwordCtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 30, bottom: 10),
                  child: Text(
                    "ยืนยันรหัสผ่าน",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    right: 30,
                    left: 30,
                    bottom: 10,
                  ),
                  child: TextField(
                    controller: confimpasswordCtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 100, right: 100),
                  child: FilledButton(
                    onPressed: createID,
                    child: const Text('สร้างบัญชี'),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 100, right: 100),
                  child: Text(text, style: TextStyle(fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('มีบัญชีอยู่แล้ว?'),
                    TextButton(
                      onPressed: login,
                      child: const Text('เข้าสูระบบ'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    Navigator.pop(context);
  }

  void createID() {
    log(nameCtl.text);
    log(phoneCtl.text);
    log(emailCtl.text);
    log(passwordCtl.text);
    log(confimpasswordCtl.text);
    if (nameCtl.text.isEmpty ||
        passwordCtl.text.isEmpty ||
        emailCtl.text.isEmpty ||
        passwordCtl.text.isEmpty ||
        confimpasswordCtl.text.isEmpty) {
      setState(() {
        text = 'you don\'t fill text';
      });
    } else if (passwordCtl.text != confimpasswordCtl.text) {
      setState(() {
        text = 'password not same';
      });
    } else {
      CustomerRegisterPostResponse
      customerRegisterPostResponse = CustomerRegisterPostResponse(
        fullname: nameCtl.text,
        phone: phoneCtl.text,
        email: emailCtl.text,
        image:
            'http://202.28.34.197:8888/contents/4a00cead-afb3-45db-a37a-c8bebe08fe0d.png',
        password: passwordCtl.text,
      );
      http
          .post(
            Uri.parse("http://192.168.16.45:3000/customers"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: customerRegisterPostResponseToJson(
              customerRegisterPostResponse,
            ),
          )
          // http
          //     .post(
          //       Uri.parse("http://10.34.10.47:3000/customers/login"),
          //       headers: {"Content-Type": "application/json; charset=utf-8"},
          //       body: customerLoginPostRequestToJson(customerLoginPostRequest),
          //     )
          .then((value) {
            log(value.body);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          })
          .catchError((error) {
            log('Error $error');
          });
    }
  }
}
