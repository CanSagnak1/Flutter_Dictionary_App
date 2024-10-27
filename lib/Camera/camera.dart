import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidictionary/Options/counter_provider.dart';
import 'package:provider/provider.dart';
import 'image_labeling.dart';

class GameIntroScreen extends StatelessWidget {
  final CameraDescription camera;

  const GameIntroScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: const Color.fromARGB(255, 46, 74, 46),
        ),
        centerTitle: true,
        title: const Text(
          "Oyun Başlıyor!",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 74, 46),
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: const Color.fromARGB(235, 149, 198, 174),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Ekran genişliği
        height: MediaQuery.of(context).size.height, // Ekran yüksekliği
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kidsBg.jpg'), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromARGB(151, 51, 96, 74),
                  border: Border.all(width: 5, color: Colors.white),
                ),
                child: Center(
                  child: Consumer<CounterProvider>(
                      builder: (context, counterProvider, child) {
                    return Text(
                      'Skor : ${counterProvider.skor}',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                )),
            SizedBox(
                width: 150,
                height: 150,
                child: Image.asset("assets/images/shotCamera.png")),
            Container(
              width: 350,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: const Color.fromARGB(151, 51, 96, 74),
                border: Border.all(width: 5, color: Colors.white),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Oyunun Kuralları",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 255, 252, 64),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 5),
                    child: Text(
                      "- Kamerayı kullanarak bir nesnenin fotoğrafını çek.\n"
                      "- Çekilen nesneye göre sana bazı kelime seçenekleri gösterilecek.\n"
                      "- Doğru kelimeyi bulmak için 10 saniyen var!\n",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageLabelingScreen(imagePath: image.path),
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Fotoğraf çekmeyi iptal ettiniz.')),
                  );
                }
              },
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromARGB(151, 51, 96, 74),
                  border: Border.all(width: 5, color: Colors.white),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: const Text(
                  'Oyuna Başla!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
