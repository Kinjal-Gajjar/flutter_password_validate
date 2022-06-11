import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: success ? Colors.green : Colors.red,
          title: Column(
            children: const [
              Text('Password Validate'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 90, left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    success ? Icons.lock_open : Icons.lock_outline,
                    color: success ? Colors.green : Colors.red,
                    size: 130,
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 207, 207, 207),
                                    width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: success ? Colors.green : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Password",
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide())),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FlutterPwValidator(
                        width: 400,
                        height: 170,
                        minLength: 8,
                        uppercaseCharCount: 2,
                        numericCharCount: 3,
                        specialCharCount: 1,
                        normalCharCount: 3,
                        onSuccess: () {
                          setState(() {
                            success = true;
                          });
                          print("MATCHED");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password is matched")));
                        },
                        controller: controller,
                        onFail: () {
                          setState(() {
                            success = false;
                          });
                          print("NOT MATCHED");
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
