import 'package:cash/DataBase/cache_helper.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String routeName = "login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController location = TextEditingController();

  GlobalKey<FormState> key1 = GlobalKey();
  GlobalKey<FormState> key2 = GlobalKey();
  GlobalKey<FormState> key3 = GlobalKey();

  late String a = "";
  late String b = "";
  late String c = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: key1,
                    child: TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        labelText: "User Name",
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User name is required";
                        } else if (value.length < 3) {
                          return "User name should be at least 3 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: key2,
                    child: TextFormField(
                      controller: age,
                      decoration: InputDecoration(
                        labelText: "Age",
                        hintText: "Enter your Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age is required";
                        } else if (value.contains(RegExp(r"[a-z][A-Z]"))) {
                          return "Age should be number";
                        } else if (int.parse(value) < 0 ||
                            int.parse(value) > 100) {
                          return "Age should contain at just numbers";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: key3,
                    child: TextFormField(
                      controller: location,
                      decoration: InputDecoration(
                        labelText: "Location",
                        hintText: "Enter your location",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Location is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (key1.currentState!.validate() == true &&
                            key2.currentState!.validate() == true &&
                            key3.currentState!.validate() == true) {
                          CacheHelper.saveData(
                              key: "Name", value: userName.text);
                          CacheHelper.saveData(key: "Age", value: age.text);
                          CacheHelper.saveData(
                              key: "Location", value: location.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Saved successfully"),
                          ));
                        }
                      },
                      color: Colors.indigo[700],
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (CacheHelper.containKey(key: "Name") == true) {
                          setState(() {
                            a = CacheHelper.getData(key: "Name");
                            b = CacheHelper.getData(key: "Age");
                            c = CacheHelper.getData(key: "Location");
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Loaded successfully"),
                          ));
                        }
                      },
                      color: Colors.indigo[700],
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Load",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (CacheHelper.containKey(key: "Name") == true) {
                          CacheHelper.clearAllData();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Removed successfully"),
                          ));
                        }
                      },
                      color: Colors.indigo[700],
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Name: $a",
                    style: const TextStyle(color: Colors.black,fontSize:23),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Age: $b",
                    style: const TextStyle(color: Colors.black,fontSize:23),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Location: $c",
                    style: const TextStyle(color: Colors.black,fontSize:23),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
