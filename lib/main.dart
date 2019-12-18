import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Shared Preference',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int defaultInt = 0;
  String defaultText = 'This is not ShP';
  double defaultDouble = 0;
  bool defaultBool = false;

  addToShP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('textVal', "I am Shared Preferences");
    prefs.setInt('intNum', 23);
    prefs.setBool('boolVal', true);
    prefs.setDouble('doubleNum', 23.2);
  }

  getFromShP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('textVal');
    int intNum = prefs.getInt('intNum');
    double doubleNum = prefs.getDouble('doubleNum');
    bool boolVal = prefs.getBool('boolVal');

    defaultText = stringValue;
    defaultInt = intNum;
    defaultDouble = doubleNum;
    defaultBool = boolVal;
  }

  void readShP() {
    setState(() {
      getFromShP();
      // defaultText = textVal;
    });
  }

  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('String =' + '$defaultText'),
                Text('Int =' + '$defaultInt'),
                Text('Double =' + '$defaultDouble'),
                Text('Bool =' + '$defaultBool'),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        addToShP();
                        final snackBar = SnackBar(
                            content: Text('Added to Shared Preferences'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.cloud_upload),
                          Text('Save'),
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        readShP();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.cloud_download),
                          Text('Get'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
