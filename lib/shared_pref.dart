import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sharedPref extends StatefulWidget {
  const sharedPref({super.key});

  @override
  State<sharedPref> createState() => _sharedPrefState();
}

class _sharedPrefState extends State<sharedPref> {
  TextEditingController nameController = TextEditingController();
  var nameValue = "No Value Saved";
  final mydecoration =  InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: BorderSide(
              color: Colors.black,width: 1
          )
      )
  );
  @override
  void initState() {
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80,right: 80),
              child: TextField(
                decoration: mydecoration,
                controller: nameController,

              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
          var name = nameController.text.toString();
          var prefs = await SharedPreferences.getInstance();
          prefs.setString("name", nameController.text.toString());
          }, child: Text('save')),

            SizedBox(height: 20,),
            Text(nameValue)
          ],
        ),
      ),
    );
  }

  void getValue() async{
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString("name");
    nameValue = getName ?? "No Value Saved";
    setState(() {

    });
  }
}
