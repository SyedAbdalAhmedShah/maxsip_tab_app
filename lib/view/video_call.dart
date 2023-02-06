import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_callkeep/flutter_callkeep.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({Key? key}) : super(key: key);
  Future<void> displayIncomingCall(BuildContext context) async {
    await CallKeep.askForPermissionsIfNeeded(context);
    final callUUID = '0783a8e5-8353-4802-9448-c6211109af51';
    final number = '+46 70 123 45 67';

    await CallKeep.displayIncomingCall(
        callUUID, number, number, HandleType.number, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video call"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Display incoming call'),
            onPressed: () => this.displayIncomingCall(context),
          )
        ],
      )),
    );
  }
}
