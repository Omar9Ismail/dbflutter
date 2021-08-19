import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? savedName;
  String? savedName2;
  String? res;


  TextEditingController? _name;
  TextEditingController? _name2;

  SharedPreferences? prefs;
  initState(){
    _name=TextEditingController();
    _name2=TextEditingController();

    // saveData();
    getLast();
    savePre();
  }

  savePre() async{
    prefs= await SharedPreferences.getInstance();
    prefs!.setString("name", _name2!.text);

  }
  getPre() async{
    prefs= await SharedPreferences.getInstance();
       res=prefs!.getString('name');
      print(res);


  }
  removePre() async{
    prefs= await SharedPreferences.getInstance();
    prefs!.remove("name");

  }




  saveData() async{
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

File file =File("$appDocPath/counter.txt");
file.writeAsString((_name?.text??''));
print(appDocPath);
}



getLast() async{
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  File file =File("$appDocPath/counter.txt");
//_counter=int.parse(await file.readAsString());
  savedName=await file.readAsString();
  print(savedName);

setState(() {


});
}
void remove(){
  removePre();
}
  void preSa() {
    savePre();
  }

  void _lastSave() {
    saveData();
  }
  void _lastSave1() {
    getLast();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          TextField(
          controller:_name2 ,
          decoration: InputDecoration(
              hintText: 'Your name'
          ),
        ),
          RaisedButton(
            onPressed:preSa,
            child: Text('Save'),
          ),
            RaisedButton(
              onPressed:remove,
              child: Text('Delete'),
            ),



          TextField(
              controller:_name ,
              decoration: InputDecoration(
                hintText: 'Your name'
              ),
            ),
            RaisedButton(
    onPressed:_lastSave,
            child: Text('Save'),
            ),
            Column(
              children: [
                RaisedButton(
                  onPressed:(){
                    getPre();
                    getLast();
                  },
                  child: Column(
                    children: [
                      Text('Show data'),
                    ],
                  ),
                ),
                Text("U are saved $savedName and : $res")
              ],
            )

          ],
        ),
      ),
    );
  }
}
