import 'package:flutter/material.dart';
import 'package:kidictionary/Categories/cat_main.dart';
import 'package:kidictionary/Camera/camera.dart';
import 'package:kidictionary/Options/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Kameraları başlatın
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CounterProvider()),
  ], child: MyApp(camera: firstCamera)));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(camera: camera),
    );
  }
}

class MainScreen extends StatefulWidget {
  final CameraDescription camera;

  const MainScreen({super.key, required this.camera});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/background.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.setVolume(0);
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  void _sesCal() {
    _audioPlayer.play(AssetSource('assets/sounds/onTap_sound.wav'),
        volume: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _sesCal();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CatMain()),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: const Color.fromARGB(151, 51, 96, 74),
                      border: Border.all(width: 0, color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        "Words",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    _sesCal();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameIntroScreen(
                          camera: widget.camera,
                        ), // camera parametresi burada
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: const Color.fromARGB(151, 51, 96, 74),
                      border: Border.all(width: 0, color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        "Game",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
