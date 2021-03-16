import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() =>runApp(MaterialApp(
  theme: ThemeData.dark(),
  debugShowCheckedModeBanner: false,
  home: HomePage(

  ),
));
class HomePage extends StatefulWidget {
  @override
  HomePageState createState(){
    return new HomePageState();
  }
}



class HomePageState extends State<HomePage>{
  String result="Hey there! I am a QR code scanner app";
  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result=qrResult;
      });
    }on PlatformException catch(ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      }
      else {
        setState(() {
          result = "Unknown error $ex";
        });
      }
    } on FormatException{
      setState(() {
        result=" You pressed the back button before scanning anything";
      });
    }catch(ex){
      setState(() {
        result = "Unknown error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[500],
      appBar: AppBar(
        title: Text("QR code scanner app"),
        backgroundColor: Colors.teal[900],
      ),
      body: SafeArea(

        child: Center(

          child: Text(result,
            style: new TextStyle(fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),


        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _scanQR();
        },
        label: Text('Scan'),
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


