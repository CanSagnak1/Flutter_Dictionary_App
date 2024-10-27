import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:kidictionary/AppbarAndDrawer/appbar.dart';
import 'package:kidictionary/AppbarAndDrawer/drawer.dart';
import 'package:kidictionary/Options/colors.dart'; // AppColors sınıfını dahil ettik

class Cat9 extends StatefulWidget {
  const Cat9({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Cat9State createState() => _Cat9State();
}

class _Cat9State extends State<Cat9> with SingleTickerProviderStateMixin {
  bool isEnglishToTurkish = true;

  final List<Map<String, String>> words = [
    {'word': 'Binder', 'meaning': 'Klasör'},
    {'word': 'Book', 'meaning': 'Kitap'},
    {'word': 'Calculator', 'meaning': 'Hesap Makinesi'},
    {'word': 'Chalk', 'meaning': 'Tebeşir'},
    {'word': 'Crayon', 'meaning': 'Akrilik Kalem'},
    {'word': 'Eraser', 'meaning': 'Silgi'},
    {'word': 'Folder', 'meaning': 'Klasör'},
    {'word': 'Glue', 'meaning': 'Yapıştırıcı'},
    {'word': 'Highlighter', 'meaning': 'Öne Çıkan Kalem'},
    {'word': 'Marker', 'meaning': 'İşaretleyici'},
    {'word': 'Notebook', 'meaning': 'Defter'},
    {'word': 'Paper', 'meaning': 'Kağıt'},
    {'word': 'Pen', 'meaning': 'Tükenmez Kalem'},
    {'word': 'Pencil', 'meaning': 'Kurşun Kalem'},
    {'word': 'Ruler', 'meaning': 'Cetvel'},
    {'word': 'Scissors', 'meaning': 'Makas'},
    {'word': 'Sharpener', 'meaning': 'Kalemtraş'},
    {'word': 'Stapler', 'meaning': 'Zımba'},
    {'word': 'Whiteboard', 'meaning': 'Beyaz Tahta'}
  ];

  final List<Color> _containerColors =
      List.generate(125, (index) => AppColors.containerDefaultBg);
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
    )..repeat(); // Sürekli dönmesi için animasyonu başlat

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
                                  width: 2,
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
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child:
                                          Cube(onSceneCreated: (Scene scene) {
                                        scene.camera.position
                                            .setValues(0, 5, 10);
                                        scene.camera.target.setValues(0, 0, 0);
                                        scene.light;
                                        scene.camera.fov = 40;
                                        scene.world.add(Object(
                                          fileName: 'assets/3d_object/küp.obj',
                                          lighting: true,
                                          scale: Vector3.all(5.0),
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