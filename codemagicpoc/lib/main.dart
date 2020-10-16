import 'package:codemagicpoc/app_config.dart';
import 'package:codemagicpoc/locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp(env: _setEnvironment()));
}

_setEnvironment() {
  Env environment;
  switch (const String.fromEnvironment('project_env')) {
    case 'preprod':
      environment = Env.preProd;
      break;
    case 'prod':
      environment = Env.prod;
      break;
    default:
      environment = Env.dev;
  }

  locator<AppEnvConfig>().environment = environment;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Env env;

  MyApp({this.env});

  Color _appColor() {
    Color appColor;
    Env env = locator<AppEnvConfig>().environment;
    if (env == Env.dev) appColor = Colors.red;
    if (env == Env.preProd) appColor = Colors.blue;
    if (env == Env.prod) appColor = Colors.green;
    return appColor;
  }

  String _appTitle() {
    String appTitle;
    Env env = locator<AppEnvConfig>().environment;
    if (env == Env.dev) appTitle = "Project DEV mode";
    if (env == Env.preProd) appTitle = "Project PREPROD mode";
    if (env == Env.prod) appTitle = "Project PROD mode";
    return appTitle;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _appTitle(),
        theme: ThemeData(
          primarySwatch: _appColor(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: _appTitle()));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            Text(
              '--------',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
