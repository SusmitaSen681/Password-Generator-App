
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_generator_app/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selected = 0;
  void changeselected(int index) {
    setState(() {
      _selected = index;
    });
  }

  bool isChecked = false;
  bool iChecked = false;
  bool issChecked = false;
  bool isssChecked = false;
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
          
          //backgroundColor: Color(0xFFFF57AC),
          //Color(0xFFFF6D91),
          appBar: AppBar(
            backgroundColor: Color(0xFF006064),
            title: Text("Password Generator"),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/img45.jpg"),
              fit: BoxFit.cover,),
              
            ),
            
            padding: EdgeInsets.all(32),
            child:ListView(
              children: [
             Column(
              
              children: [
                Image(image: new AssetImage('images/passy.jpg'),width:200,
                height:200),
                const SizedBox(
                      height: 15,
                    ),
                Row(
                  children: [
                    Expanded(child: Text("Uppercase",
                   // style:TextStyle(fontFamily: "Roboto",
                   //fontWeight: FontWeight.w700 ,fontSize: 8))),
                    )),
                    Expanded(
                        child: Checkbox(
                            value: this.isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                this.isChecked = value!;
                              });
                            })),
                    Expanded(child: Text("Lowercase")),
                    Expanded(
                        child: Checkbox(
                            value: this.iChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                this.iChecked = value!;
                              });
                            })),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Numbers")),
                    Expanded(
                        child: Checkbox(
                            value: this.issChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                this.issChecked = value!;
                              });
                            })),
                    Expanded(child: Text("Symbols")),
                    Expanded(
                        child: Checkbox(
                            value: this.isssChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                this.isssChecked = value!;
                              });
                            })),
                  ],
                ),
                Row(
                  children: [
                    Expanded(flex: 1,
                    
                     child: Text("Length")),
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
                Text("Random Password Generator",
                style:TextStyle(fontSize: 25,color: Color(0xFFB71C1C),
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
                              final data = ClipboardData(text: controller.text);
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
               ]) ),
          drawer: Drawer(
            child: Container(decoration: BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/drawerback.jpg"),
              fit: BoxFit.cover,),
            ),
          child: Builder(
            
              builder: (context) => Container(
                
                
                  child: ListView(
                    padding: EdgeInsets.zero, 
                children: <Widget>[
                 
                  DrawerHeader(
                    
                    child:Container(
                      
                      padding: EdgeInsets.only(top:20),
                      child:Text("You deserve to get hacked if your password is your name!!",
                      style: TextStyle(color: Color(0xFFB71C1C),
                      fontSize: 23,
                      ),
                      ),   
                        
                         
                    )  ),
                  ListTile(
                      trailing: Icon(Icons.password_rounded),
                      title: Text("User choice password",style: TextStyle(
                      fontSize: 15,
                      ),),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return UserChoice("User Choice Password");
                            }),
                          );
                        });
                      }),
                  
                  
                ],
              )),
            ),
          ),
    )));
  }

  String generatePassword({
    bool hasLetters = true,
    bool hasnumbers = true,
    bool hasSpecial = true,
  }) {
    String chars = '';
    final lengths = int.parse(length.text);
    final letterlower = 'abcdefghijklmnopqrstuvwxyz';
    final letterupper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final special = '@#\$%&*!+=-?/^[]{}<>,.()';

    if (iChecked == true) {
      chars += '$letterlower';
    }
    ;
    if (isChecked == true) {
      chars += '$letterupper';
    }
    ;
    if (issChecked == true) {
      chars += '$numbers';
    }
    ;
    if (isssChecked == true) {
      chars += ' $special';
    }
    ;

    return List.generate(lengths, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).toSet().join('');
  }

  void reset() {
    length.text = '';
    controller.text = '';
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: 
       Color(0xFF006064)),
      child: Text("Generate Password"),
      onPressed: () {
        final password = generatePassword();
        controller.text = password;
      },
    );
  }
}

