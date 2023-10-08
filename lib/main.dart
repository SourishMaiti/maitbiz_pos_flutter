import 'dart:ui';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

String info = ""; 

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _infoController = TextEditingController();

  // Simulated login function
  void _login() {
    String username = _emailController.text;
    String password = _passwordController.text;

    // Perform authentication here, e.g., check credentials, API call, etc.
    // For demonstration purposes, just print the credentials.
    print("Username: $username");
    print("Password: $password");

    // Navigate to the home screen after successful login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(),
      ),
    );
  }

  //--web-port=8888 --web-hostname=192.168.1.90
  asyncDeviceInfo() async {
    String os = "";
    try {
      os = Platform.operatingSystem;
      info += "\nOS: " + os + ", " ;
      print("OS:: " + os);
    } catch(e){
      print(e);
    }

    try{
      var pixelRatio = window.devicePixelRatio;

      //Size in physical pixels
      var physicalScreenSize = window.physicalSize;
      var physicalWidth = physicalScreenSize.width;
      var physicalHeight = physicalScreenSize.height;

      //Size in logical pixels
      var logicalScreenSize = window.physicalSize / pixelRatio;
      var logicalWidth = logicalScreenSize.width;
      var logicalHeight = logicalScreenSize.height;

      //Padding in physical pixels
      var paddings = window.padding;

      //Safe area paddings in logical pixels
      var paddingLeft = window.padding.left / window.devicePixelRatio;
      var paddingRight = window.padding.right / window.devicePixelRatio;
      var paddingTop = window.padding.top / window.devicePixelRatio;
      var paddingBottom = window.padding.bottom / window.devicePixelRatio;

      //Safe area in logical pixels
      var safeWidth = logicalWidth - paddingLeft - paddingRight;
      var safeHeight = logicalHeight - paddingTop - paddingBottom;

      info += "\nSafe Area: " + safeWidth.toString() + "x" + safeHeight.toString() ;

      //Size in physical pixels
      var physicalSize = window.physicalSize;
      var phyWidth = physicalSize.width;
      var phyHeight = physicalSize.height;
      info += ",  Physical Area: " + phyWidth.toString() + "x" + phyHeight.toString() ;
    }catch(e){
      print(e);
    }

    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
      print(deviceInfo.data);
      info += "\nDeviceInfo: " + deviceInfo.data.toString();
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    _emailController.text = 'pos1';
    _passwordController.text = 'pos1';

    //info = "";
    try {
      info +=  '\nDate: ' + DateTime.timestamp().toString();
      var mediaQuery = MediaQuery.of(context);
      var w = mediaQuery.size.width;
      var h = mediaQuery.size.height;
      Size size = window.physicalSize / window.devicePixelRatio;
      info += ', \nOrientation: ' + MediaQuery
          .of(context)
          .orientation
          .name + ', Size: ' + window.devicePixelRatio.toString() + '(ratio)' +
          size.width.toString() + 'x' + size.height.toString() + ', Area: ' +
          w.toString() + "x" + h.toString();
    }catch(e){
      print(e);
    }

    asyncDeviceInfo();

    _infoController.text = info;
    print("\nBasic Info: \n" + info);

    return Scaffold(
      appBar: AppBar(
        title: Text('MaitBiz POS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,

              decoration: InputDecoration(
                labelText: 'Username',

              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            TextButton(
              onPressed: _login,
              child: Text('Login'),
            ),

            TextField(
              controller: _infoController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Basic Info',

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
