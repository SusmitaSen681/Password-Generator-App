import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_generator_app/main.dart';

class UserChoice extends StatefulWidget {
  final String title;
  UserChoice(this.title);

  @override
  _UserChoiceState createState() => _UserChoiceState();
}
class _UserChoiceState extends State<UserChoice> {
  TextEditingController uppercase = TextEditingController();
  TextEditingController lowercase = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController symbol = TextEditingController();
  TextEditingController length = TextEditingController();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // backgroundColor: Color(0xFFFF57AC),
            //Color(0xFFFF6D91),
            appBar: AppBar(
              backgroundColor: Color(0xFF006064),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return MyApp();
                })),
              ),
              title: Text("User Choice Password"),
              centerTitle: true,
            ),
            body: Center(
                child: Container(
                  decoration: BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/img45.jpg"),
              fit: BoxFit.cover,),
            ),
              
              child: Container(
                padding: EdgeInsets.all(32),
                
                 child: Center(
                  child: ListView(
                    
                    children: [
                   
                Column(
                  
                  children: [
                    
                        Image(image: new AssetImage('images/passy.jpg'),width:200,
                height:150),
                const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: uppercase,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Uppercase",
                          hintText: "Enter Uppercase letter"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: lowercase,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Lowercase",
                          hintText: "Enter Lowercase letter"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number",
                              hintText: "Enter Number"),
                        ),
                      ),
                      Container(width: 5.0),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: symbol,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Symbol",
                              hintText: "Enter Special Symbol"),
                        ),
                      ),
                    ]),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text("Length")),
                        const SizedBox(
                          height: 90,
                        ),
                        Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: length,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Random Password Generator",style:TextStyle(fontSize: 25,color: Color(0xFFB71C1C),
                fontStyle: FontStyle.italic),),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                        controller: controller,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  final data =
                                      ClipboardData(text: controller.text);
                                  Clipboard.setData(data);

                                  Fluttertoast.showToast(
                                      msg: "Copied",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white);
                                }))),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(child: buildButton()),
                        Container(width: 9.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: 
       Color(0xFFB71C1C)),
                              child: Text("Reset"),
                              onPressed: () {
                                setState(() {
                                  reset();
                                });
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ])),
     ) ))));
  }

  String generatePassword({
    required bool islowercase,
    required bool isupercase,
    required bool isnumber,
    required bool isspecial,
  }) {
    String chars = '';
    final lengths = int.parse(length.text);
    final letterlower = uppercase.text;
    final letterupper = lowercase.text;
    final numbers = int.parse(number.text);
    final special = symbol.text;

    chars += (islowercase ? '$letterlower' : '');

    chars += (isupercase ? '$letterupper' : '');

    chars += (isnumber ? '$numbers' : '');

    chars += (isspecial ? '$special' : '');

    return List.generate(lengths, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).toSet().join('');
  }

  void reset() {
    uppercase.text = '';
    lowercase.text = '';
    symbol.text = '';
    number.text = '';
    length.text = '';
    controller.text = '';
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: 
       Color(0xFF006064)),
      child: Text("Generate Password"),
      onPressed: () {
        final password = generatePassword(
            islowercase: true,
            isupercase: true,
            isnumber: true,
            isspecial: true);
        controller.text = password;
      },
    );
  }
}


