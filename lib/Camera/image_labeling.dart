import 'dart:async'; // Asenkron işlemler için
import 'package:flutter/material.dart'; // Flutter'ın temel bileşenleri için
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart'; // Google ML Kit image labeling kütüphanesini içe aktar
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:kidictionary/Options/counter_provider.dart';
import 'package:provider/provider.dart';

// Resim etiketleme ekranı için StatefulWidget tanımı
class ImageLabelingScreen extends StatefulWidget {
  final int skor = 0;
  const ImageLabelingScreen({super.key, required this.imagePath});

  final String imagePath; // Çekilen resmin yolu

  @override
  // ignore: library_private_types_in_public_api
  _ImageLabelingScreenState createState() => _ImageLabelingScreenState();
}

// State sınıfı
class _ImageLabelingScreenState extends State<ImageLabelingScreen> {
  // ignore: unused_field
  List<ImageLabel> _detectedLabels = []; // Algılanan etiketler

  bool _gameStarted = false; // Oyunun başlama durumu
  List<String> _options = []; // Seçenekler
  String _selectedLabel = ""; // Seçilen etiket
  int _timeLeft = 10; // Kalan süre (10 saniye)
  Timer? _timer; // Zamanlayıcı

  @override
  void dispose() {
    _timer?.cancel(); // Zamanlayıcıyı iptal et
    super.dispose(); // Üst sınıfın dispose metodunu çağır
  }

  @override
  void initState() {
    super.initState();
    _detectLabels(); // Etiketleri algılamaya başla
  }

  // Resim etiketlerini algılamak için
  Future<void> _detectLabels() async {
    final inputImage =
        InputImage.fromFilePath(widget.imagePath); // Resmi dosya yolundan al
    final options =
        ImageLabelerOptions(confidenceThreshold: 0.7); // Algılama güven eşiği
    final imageLabeler =
        ImageLabeler(options: options); // ImageLabeler nesnesini oluştur
    final detectedLabels =
        await imageLabeler.processImage(inputImage); // Resmi işle

    if (detectedLabels.isNotEmpty) {
      // Algılanan etiketlerden birini seç
      setState(() {
        _selectedLabel = detectedLabels[0]
            .label; // İlk etiketi seçilen etiket olarak belirle
      });
      _generateOptions(detectedLabels[0].label); // Seçenekleri oluştur
    }

    setState(() {
      _detectedLabels = detectedLabels; // Algılanan etiketleri güncelle
    });

    imageLabeler.close(); // ImageLabeler nesnesini kapat
  }

  // Rastgele seçenekler oluştur
  void _generateOptions(String correctLabel) {
    final random = Random(); // Rastgele nesne
    final possibleWords = [
      "Apple",
      "Car",
      "Pen",
      "Computer",
      "Phone",
      "Book",
      "Table",
      "Chair",
      "Shoe",
      "Watch",
      "Glass",
      "Bottle",
      "Ball",
      "Key",
      "Camera",
      "Bag",
      "Hat",
      "Lamp",
      "Desk",
      "Pillow",
      "Fork",
      "Knife",
      "Spoon",
      "Cup"
    ];

    // Doğru kelimeyi dışındaki 3 rastgele kelimeyi seç
    _options = [];

    // Doğru kelime dışında kalanları filtreleyerek bir liste oluşturur
    List<String> filteredWords =
        possibleWords.where((word) => word != correctLabel).toList();

    // Rastgele 3 kelime seçer
    for (int i = 0; i < 3; i++) {
      int randomIndex = random.nextInt(filteredWords.length);
      _options.add(filteredWords[randomIndex]);
      filteredWords.removeAt(randomIndex); // Seçilen kelimeyi listeden çıkar
    }

    _options.add(correctLabel); // Doğru kelimeyi ekle
    _options.shuffle(random); // Seçenekleri karıştır
    _startGame(); // Oyunu başlat
  }

  // Oyunu başlatmak için
  void _startGame() {
    _gameStarted = true; // Oyunun başladığını belirt
    _timeLeft = 10; // Süreyi sıfırla
    // Her saniye kalan süreyi güncelle
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--; // Kalan süreyi azalt
        });
      } else {
        // Süre dolduğunda
        _showResult("Süre doldu! Yanlış cevap."); // Sonucu göster
        _timer?.cancel(); // Zamanlayıcıyı durdur
      }
    });
  }

  // Cevabı kontrol etmek için
  void _checkAnswer(String selectedOption) {
    _timer?.cancel(); // Zamanlayıcıyı durdur

    if (selectedOption == _selectedLabel) {
      // Doğru cevap
      _showResult("Doğru cevap, 1 puan kazandın. Hadi Devam Edelim...",
          isCorrect: true);
      context.read<CounterProvider>().artir();
    } else {
      // Yanlış cevap
      _showResult("Yanlış cevap. Doğru cevap: $_selectedLabel",
          isCorrect: false);
    }
  }

  // Sonucu gösterme
  void _showResult(String message, {bool isCorrect = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 46, 74, 46),
          title: Text(
            isCorrect ? "Başarılı" : "Başarısız",
            style: const TextStyle(color: Colors.white),
          ), // Başarılı ya da başarısız başlığı
          content: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ), // Mesajı göster
          actions: [
            InkWell(
                onTap: () {
                  if (isCorrect) {
                    _openCamera();
                    Navigator.of(context).pop(); // Dialogdan çık
                  } else {
                    Navigator.of(context).pop(); // Dialogdan çık
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: const Color.fromARGB(151, 51, 96, 74),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      isCorrect ? "Devam Et" : "Ana Ekran",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }

  void _openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => ImageLabelingScreen(imagePath: image.path),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fotoğraf çekmeyi iptal ettiniz.')),
      );
    }
  }

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
          "Doğru Seçeneği Seç",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 74, 46),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: const Color.fromARGB(235, 149, 198, 174),
      ),
      body: _gameStarted
          ? Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image:
                    AssetImage('assets/images/kidsBg.jpg'), // Arka plan resmi
                fit: BoxFit.cover,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Geri sayım için dairesel ilerleme çubuğu
                      CircularProgressIndicator(
                        value: _timeLeft / 10, // 10 saniye üzerinden geri sayım
                        backgroundColor: const Color.fromARGB(
                            166, 11, 91, 43), // Arka plan rengi
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white), // İlerleme rengi
                        strokeWidth: 10,
                        strokeAlign: 5, // Çubuğun kalınlığı
                      ),
                      Text(
                        "$_timeLeft", // Kalan süreyi göster
                        style: const TextStyle(
                            color: Color.fromARGB(166, 11, 91, 43),
                            fontSize: 30,
                            fontWeight: FontWeight.bold), // Yazı stil
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ..._options.map((option) {
                    return InkWell(
                      onTap: () => _checkAnswer(
                          option), // Seçeneklere tıklanıldığında cevap kontrol et
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20), // Kenar boşlukları
                        padding: const EdgeInsets.all(15), // İç boşluk
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: const Color.fromARGB(116, 24, 89, 11),
                          border: Border.all(width: 5, color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            option, // Seçenek metni
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white), // Yazı stili
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image:
                    AssetImage('assets/images/kidsBg.jpg'), // Arka plan resmi
                fit: BoxFit.cover,
              )),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Analiz Ediliyor...",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(116, 24, 89, 11),
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(116, 24, 89, 11),
                      strokeWidth: 5,
                    ), // Yükleniyor animasyonu
                  ),
                ],
              ),
            ),
    );
  }
}
