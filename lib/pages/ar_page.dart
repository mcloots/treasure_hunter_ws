import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_hunter/globals.dart';
import 'package:treasure_hunter/models/location_model.dart';

class ArPage extends StatefulWidget {
  final Location location;

  const ArPage({super.key, required this.location});

  @override
  State<ArPage> createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  UnityWidgetController? _unityWidgetController;
  bool _isCameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
  }

  // Check for camera permission

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraPermissionGranted) {
      return const Center(
          child: Text('Camera permission is required to proceed.'));
    }

    return UnityWidget(
      onUnityCreated: _onUnityCreated,
      onUnityMessage: onUnityMessage,
      onUnitySceneLoaded: onUnitySceneLoaded,
      useAndroidViewSurface: true,
      borderRadius: const BorderRadius.all(Radius.circular(70)),
    );
  }

  // Send chosen location to Unity!
  void _sendLocation() {
  }

  // Send username to Unity!
  void _sendUsername() {
  }

  void onUnityMessage(message) {
    print('RECEIVED MESSAGE FROM UNITY: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    } else {
      print('Received scene loaded from unity: null');
    }
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }
}
