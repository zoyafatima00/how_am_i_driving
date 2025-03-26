import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../utils/color_resources.dart';

class LiveStreamingScreen extends StatefulWidget {
  static const route = '/LiveStreamingScreen';

  @override
  _LiveStreamingScreenState createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> {
  late VlcPlayerController _vlcController;
  late WebSocketChannel _channel;
  Uint8List? _processedFrame;
  bool _isConnected = false;
  Timer? _frameTimer;

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  void _initStream() {
    // 1. Initialize VLC player
    _vlcController = VlcPlayerController.network(
      "rtmp://192.168.18.30/live/gopro",
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    // 2. Connect to WebSocket
    _connectWebSocket();

    // 3. Start frame capture
    _startFrameCapture();
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.18.30:8000/ws/video-feed'),
    );

    _channel.stream.listen(
      (data) {
        if (data is Uint8List) {
          setState(() => _processedFrame = data);
        }
      },
      onError: (error) {
        print("WebSocket error: $error");
        _reconnect();
      },
      onDone: () {
        print("WebSocket closed");
        _reconnect();
      },
    );
  }

  void _startFrameCapture() {
    const frameInterval = Duration(milliseconds: 100); // 10 FPS

    _frameTimer = Timer.periodic(frameInterval, (_) async {
      if (!_vlcController.value.isInitialized) return;

      try {
        final snapshot = await _vlcController.takeSnapshot();
        if (snapshot != null && _channel.sink != null) {
          _channel.sink.add(snapshot);
        }
      } catch (e) {
        print("Frame capture error: $e");
      }
    });
  }

  void _reconnect() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) _connectWebSocket();
    });
  }

  @override
  void dispose() {
    _frameTimer?.cancel();
    _vlcController.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Stream Processing")),
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),

          Text(
            "Real-Time Video",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'arial',
                color: AppColors.Text_COLOR),
          ),
          SizedBox(
            height: 7.h,
          ),
          // Original Stream
          Container(
            height: 240, // Set height to ensure equal size
            child: VlcPlayer(
              controller: _vlcController,
              aspectRatio: 16 / 9,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          Text(
            "Processed Video",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'arial',
                color: AppColors.Text_COLOR),
          ),
          SizedBox(
            height: 5.h,
          ),

          // Processed Stream (Make sure it has the same size)
          Container(
            height: 240, // Set height to match the original stream
            color: Colors.black,
            child: _processedFrame != null
                ? Image.memory(_processedFrame!, fit: BoxFit.cover)
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
