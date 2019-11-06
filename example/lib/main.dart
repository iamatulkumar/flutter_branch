import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_android_lifecycle/flutter_android_lifecycle.dart';
import 'package:flutter_branch/flutter_branch.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  String _data = '-';
  String generatedLink = '-';
  String error = '-';

  @override
  void initState() {
    super.initState();

    initPlatformState();
    try {
      setUpBranch();
    } catch (error) {
      setState(() {
        this.error = error.toString();
      });
      print("BRANCH ERROR ${error.toString()}");
    }
  }

  void setUpBranch() {
    if (Platform.isAndroid) {
      FlutterBranch.setupBranchIO();
    }

    FlutterBranch.listenToDeepLinkStream().listen((string) {
      print("DEEPLINK $string");
      setState(() {
        this._data = string;
      });
    });
//    if (Platform.isAndroid) {
//      FlutterAndroidLifecycle.listenToOnStartStream().listen((string) {
//        print("ONSTART");
//        FlutterBranch.setupBranchIO();
//      });
//      FlutterAndroidLifecycle.listenToOnPauseStream().listen((string) {
//        print("ONPAUSE");
//
//      });
//    }
  }

  Future<void> initPlatformState() async {
    String platformVersion = "sdfghj";
    try {} on PlatformException {}

    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_data\n '),
        ),
      ),
    );
  }
}
