import 'package:flutter/material.dart';
import 'package:kidictionary/Options/colors.dart';
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

// Drawer widget'ını ayrı bir sınıf olarak oluşturuyoruz
class CustomDrawer extends StatelessWidget {
  final List<Color> textColors;

  // Constructor ile renk verilerini alıyoruz
  const CustomDrawer({super.key, required this.textColors});

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      '1. Animals (Hayvanlar):',
      '2. Toys (Oyuncaklar):',
      '3. Colors (Renkler):',
      '4. Fruits (Meyveler):',
      '5. Vehicles (Araçlar):',
      '6. Food (Yemekler):',
      '7. Clothing (Giysiler):',
      '8. Furniture (Mobilyalar):',
      '9. School (Okul):',
      '10. Nature (Doğa):',
    ];

    List<Image> icons = [
      Image.asset(
        'assets/images/menuIcon/animals.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/toys.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/colors.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/fruits.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/vehicles.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/food.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/clothing.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/furniture.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/school.png',
        width: 25,
        height: 25,
      ),
      Image.asset(
        'assets/images/menuIcon/nature.png',
        width: 25,
        height: 25,
      ),
    ];
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

    return Drawer(
      elevation: 50,
      backgroundColor: AppColors.drawerBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(border: Border.all(width: 0)),
            child: const Center(
              child: Text(
                "Categories",
                style: TextStyle(
                  color: AppColors.drawerHeaderText,
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          for (int i = 0; i < 10; i++)
            ListTile(
              leading: (icons[i]),
              title: Text(
                menuItems[i],
                style: const TextStyle(
                  color: AppColors.drawerText,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => categories[i]),
                );
              },
            ),
        ],
      ),
    );
  }
}
