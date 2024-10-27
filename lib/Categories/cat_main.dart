import 'package:flutter/material.dart';
import 'package:kidictionary/Categories/cat1.dart';
import 'package:kidictionary/Categories/cat2.dart';
import 'package:kidictionary/Categories/cat3.dart';
import 'package:kidictionary/Categories/cat4.dart';
import 'package:kidictionary/Categories/cat5.dart';
import 'package:kidictionary/Categories/cat6.dart';
import 'package:kidictionary/Categories/cat7.dart';
import 'package:kidictionary/Categories/cat8.dart';
import 'package:kidictionary/Categories/cat9.dart';
import 'package:kidictionary/Categories/cat10.dart';

List<Widget> categories = [
  const Cat1(),
  const Cat2(),
  const Cat3(),
  const Cat4(),
  const Cat5(),
  const Cat6(),
  const Cat7(),
  const Cat8(),
  const Cat9(),
  const Cat10()
];
List<String> menuItems = [
  'Animals (Hayvanlar)',
  'Toys (Oyuncaklar)',
  'Colors (Renkler)',
  'Fruits (Meyveler)',
  'Vehicles (Araçlar)',
  'Food (Yemekler)',
  'Clothing (Giysiler)',
  'Furniture (Mobilyalar)',
  'School (Okul)',
  'Nature (Doğa)',
];
List<Image> menuIcon = [
  Image.asset('assets/images/menuIcon/animals.png'),
  Image.asset('assets/images/menuIcon/toys.png'),
  Image.asset('assets/images/menuIcon/colors.png'),
  Image.asset('assets/images/menuIcon/fruits.png'),
  Image.asset('assets/images/menuIcon/vehicles.png'),
  Image.asset('assets/images/menuIcon/food.png'),
  Image.asset('assets/images/menuIcon/clothing.png'),
  Image.asset('assets/images/menuIcon/furniture.png'),
  Image.asset('assets/images/menuIcon/school.png'),
  Image.asset('assets/images/menuIcon/nature.png'),
];

class CatMain extends StatelessWidget {
  const CatMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Ki'Dictionary",
            style: TextStyle(
              color: Color.fromARGB(255, 46, 74, 46),
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: const Color.fromARGB(235, 149, 198, 174),
        ),
        body: const MerdivenAnimasyonu(),
      ),
    );
  }
}

class MerdivenAnimasyonu extends StatefulWidget {
  const MerdivenAnimasyonu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MerdivenAnimasyonuState createState() => _MerdivenAnimasyonuState();
}

class _MerdivenAnimasyonuState extends State<MerdivenAnimasyonu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<Offset>> _animations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Her bir container için sağdan sola animasyon oluşturuyoruz.
    for (int i = 0; i < 10; i++) {
      _animations.add(Tween<Offset>(
        begin: const Offset(1, 0), // Sağın dışından başlıyor
        end: const Offset(0, 0), // Orta konuma geliyor
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.1, 1.0, curve: Curves.easeInOut),
        ),
      ));
    }

    // Animasyonu başlat
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alıyoruz
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight =
        screenHeight / 10; // 10 container olduğu için ekranı 10'a bölüyoruz.

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/kidsBg.jpg'), // Arka plan resmi
        fit: BoxFit.cover, // Resmi ekranın tamamını kapsayacak şekilde ayarla
      )),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: _animations[index],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => categories[index]),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: const Color.fromARGB(109, 149, 198, 174),
                      border: Border.all(width: 0, color: Colors.white)),
                  height: containerHeight,
                  // Dinamik yüksekliği buraya veriyoruz

                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 50, height: 50, child: menuIcon[index]),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          menuItems[index],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 46, 74, 46),
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
