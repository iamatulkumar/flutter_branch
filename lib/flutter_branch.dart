import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterBranch {
  static const MethodChannel _messageChannel = const MethodChannel('flutter_branch_io/message');
  static const EventChannel _eventChannel = const EventChannel('flutter_branch_io/event');
  static const EventChannel _generatedLinkChannel = const EventChannel('flutter_branch_io/generated_link');

  static Stream<String> mainStream;
  static Stream<String> generatedLinkStream;

  static const MethodChannel _channel =
      const MethodChannel('flutter_branch');

  static void setupBranchIO() {
    if (Platform.isAndroid) _messageChannel.invokeMethod('initBranchIO');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void setUserIdentity( String userId ) {
    Map<String, dynamic> _params = {};
    _params["userId"] = userId;
    _messageChannel.invokeMethod("setUserIdentity", _params);
  }

  static void clearUserIdentity( String userId ) {
    _messageChannel.invokeMethod("clearUserIdentity");
  }

  static Future<String> getLatestParam() async {
    return await _messageChannel.invokeMethod('getLatestParam');
  }

  static Future<String> getFirstParam() async {
    return await _messageChannel.invokeMethod('getFirstParam');
  }

  static Stream<String> listenToDeepLinkStream() {
    if ( mainStream == null ) mainStream = _eventChannel.receiveBroadcastStream().cast<String>();
    return mainStream;
  }

  static Stream<String> listenToGeneratedLinkStream() {
    if ( generatedLinkStream == null ) generatedLinkStream = _generatedLinkChannel.receiveBroadcastStream().cast<String>();
    return generatedLinkStream;
  }


}
