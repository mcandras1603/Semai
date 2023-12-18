import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:semaai/provider/cart_provider.dart';
import 'package:semaai/screens/product_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Onboarding()),);
    });
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(98, 174, 53, 1.0),
        body: Center(
            child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/splashscreen.png"), fit: BoxFit.cover,
                    )
                )
            )
          //color: Colors.lightGreen,2
        ),
      ),
    );
  }
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _Onboarding();
}
class _Onboarding extends State<Onboarding> {
  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen, fontFamily: 'Domine'),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Image.asset(
                    'assets/images/onboarding.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                Container(
                    height: 55,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 21,
                      vertical: 42,
                    ),
                    child: Builder(
                      builder: (context) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                            "Mulai",
                            style: TextStyle(color: Colors.white, fontSize: 20,)
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// RGB (98, 174, 53, 1.0) HIJAU TUA
// RGB (150, 213, 113, 1.0) HIJAU MUDA
// RGB (78, 100, 65, 1.0) ARMY
// RGB (180, 166, 48, 1.0) EMAS
// RGB (233, 90, 45, 1.0) MERAH ERROR
// RGB (178, 198, 166, 1.0) HIJAU PUCAT

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = "";
  var password = "";
  void fetchlogin()async{
    final response = await http.post(
      Uri.parse('https://semai.000webhostapp.com/public/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if(response.body=='true') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }else{
      print(response.body);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen, fontFamily: 'Domine'),
      title: "My ITK Dude",
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Image.asset(
                    "assets/images/login.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: const Text(
                    "Login Akun Anda",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Masukkan Email Anda",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => email = value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  width: double.infinity,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Masukkan Password Anda",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => password = value),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 28,
                  ),
                  child: Builder(
                    builder: (context) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {

                        FocusScope.of(context).unfocus();
                        if (email.isEmpty || password.isEmpty) {
                          const message = 'Input Data Please';
                          const snackBar = SnackBar(
                            content: Text(
                              message,
                              style: TextStyle(fontSize: 20),
                            ),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          fetchlogin();
                          final message =
                              'Email: $email\nPassword: $password';
                          final snackBar = SnackBar(
                            content: Text(
                              message,
                              style: const TextStyle(fontSize: 20),
                            ),
                            backgroundColor: Colors.lightGreen,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),

                    ),
                  ),
                )],
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}
