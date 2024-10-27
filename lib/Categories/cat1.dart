import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:kidictionary/AppbarAndDrawer/appbar.dart';
import 'package:kidictionary/AppbarAndDrawer/drawer.dart';
import 'package:kidictionary/Options/colors.dart';
import 'package:audioplayers/audioplayers.dart';

// 'Cat1' isimli bir StatefulWidget sınıfı tanımlanıyor.
class Cat1 extends StatefulWidget {
  const Cat1({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Cat1State createState() => _Cat1State();
}

// 'Cat1' widget'ı için durum sınıfı.
class _Cat1State extends State<Cat1> with SingleTickerProviderStateMixin {
  List<String> object3d = [
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
    'assets/3d_object/tavuk.obj',
  ];
  bool isEnglishToTurkish = true;
  final List<Map<String, String>> words = [
    {'word': 'Bear', 'meaning': 'Ayı'},
    {'word': 'Cat', 'meaning': 'Kedi'},
    {'word': 'Dolphin', 'meaning': 'Yunus'},
    {'word': 'Dog', 'meaning': 'Köpek'},
    {'word': 'Elephant', 'meaning': 'Fil'},
    {'word': 'Fish', 'meaning': 'Balık'},
    {'word': 'Giraffe', 'meaning': 'Zürafa'},
    {'word': 'Horse', 'meaning': 'At'},
    {'word': 'Kangaroo', 'meaning': 'Kanguru'},
    {'word': 'Lion', 'meaning': 'Aslan'},
    {'word': 'Monkey', 'meaning': 'Maymun'},
    {'word': 'Owl', 'meaning': 'Baykuş'},
    {'word': 'Parrot', 'meaning': 'Papağan'},
    {'word': 'Penguin', 'meaning': 'Penguen'},
    {'word': 'Rabbit', 'meaning': 'Tavşan'},
    {'word': 'Snake', 'meaning': 'Yılan'},
    {'word': 'Tiger', 'meaning': 'Kaplan'},
    {'word': 'Turtle', 'meaning': 'Kaplumbağa'},
    {'word': 'Whale', 'meaning': 'Balina'},
    {'word': 'Zebra', 'meaning': 'Zebra'},
  ];

  final List<Color> _containerColors = List.generate(
    125,
    (index) => AppColors.containerDefaultBg,
  );
  final List<Color> _textColors =
      List.generate(125, (index) => AppColors.containerTextDefault);
  final List<double> _heights = List.generate(125, (index) => 60);
  final List<double> _widths = List.generate(125, (index) => 0.8);
  final List<bool> _show3DObject = List.generate(125, (index) => false);

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeColorOnPress(int index, String word, String meaning) {
    setState(() {
      _containerColors[index] = AppColors.containerPressedBg;
      _textColors[index] = AppColors.containerTextPressed;
      _heights[index] = 300;
      _widths[index] = 0.95;
      _show3DObject[index] = true;
    });
  }

  void _resetColorOnRelease(int index) {
    Future.delayed(const Duration(milliseconds: 10000), () {
      setState(() {
        _containerColors[index] = AppColors.containerDefaultBg;
        _textColors[index] = AppColors.containerTextDefault;
        _heights[index] = 60;
        _widths[index] = 0.8;
        _show3DObject[index] = false;
      });
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  void _sesCal() {
    _audioPlayer.play(AssetSource('assets/sounds/onPressed_sound.wav'),
        volume: 100);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.scafoldBg,
        appBar: CustomAppBar(
          toggleLanguage: () {
            setState(() {
              isEnglishToTurkish = !isEnglishToTurkish; // Dil değiştir
            });
          },
        ),
        drawer: CustomDrawer(textColors: _textColors),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/kidsBg.jpg'), // Arka plan resmi dosya yolu
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < words.length; i++)
                  GestureDetector(
                    onLongPressStart: (details) {
                      _sesCal();
                      _changeColorOnPress(
                          i, words[i]['word']!, words[i]['meaning']!);
                    },
                    onLongPressEnd: (details) {
                      _resetColorOnRelease(i);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: _heights[i],
                            width: screenWidth * _widths[i],
                            decoration: BoxDecoration(
                              color: _containerColors[i],
                              border: Border.all(
                                  width: 0,
                                  color: AppColors.containerBorderColor),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth * 0.1)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  _containerColors[i] ==
                                          AppColors.containerDefaultBg
                                      ? (isEnglishToTurkish
                                          ? words[i]['word']!
                                          : words[i]['meaning']!)
                                      : (isEnglishToTurkish
                                          ? words[i]['meaning']!
                                          : words[i]['word']!),
                                  style: TextStyle(
                                    color: _textColors[i],
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                if (_show3DObject[i])
                                  RotationTransition(
                                    turns: _rotationAnimation,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child:
                                          Cube(onSceneCreated: (Scene scene) {
                                        scene.camera
                                          ..position.setValues(0, 0, 15)
                                          ..target.setValues(0, 0, 0);

                                        scene.camera.fov = 65;
                                        scene.world.add(Object(
                                          fileName: object3d[i],
                                          lighting: true,
                                          scale: Vector3.all(20.0),
                                        ));
                                      }),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
