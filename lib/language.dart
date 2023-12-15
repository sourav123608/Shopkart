import 'package:ecom/login.dart';
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  static String id = "language";
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

enum BestTutorSite { english, hindi, bengali, telgu, tamil }

class _LanguageState extends State<Language> {
  BestTutorSite _site = BestTutorSite.english;
  int flag = 1;

  void route() {
    if (flag == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.language),
        actions: const [Icon(Icons.help)],
        centerTitle: true,
        title: const Text(
          "Choose your Language",
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 3),
              leading: Radio(
                value: BestTutorSite.english,
                activeColor: Colors.black,
                hoverColor: Colors.black,
                groupValue: _site,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    _site = value!;
                    flag = 1;
                  });
                },
              ),
              tileColor: Colors.yellow,
              title: const Text(
                "English",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.0),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 4),
              leading: Radio(
                value: BestTutorSite.hindi,
                groupValue: _site,
                activeColor: Colors.black,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    _site = value!;
                    flag = 1;
                  });
                },
              ),
              tileColor: const Color.fromARGB(255, 243, 96, 145),
              title: const Text(
                "हिन्दी",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.0),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 4),
              leading: Radio(
                value: BestTutorSite.bengali,
                activeColor: Colors.black,
                groupValue: _site,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    _site = value!;
                    flag = 1;
                  });
                },
              ),
              tileColor: const Color.fromARGB(255, 114, 247, 182),
              title: const Text(
                "বাংলা",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.0),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 4),
              leading: Radio(
                value: BestTutorSite.telgu,
                activeColor: Colors.black,
                groupValue: _site,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    _site = value!;
                    flag = 1;
                  });
                },
              ),
              tileColor: const Color.fromARGB(255, 82, 141, 244),
              title: const Text(
                "தமிழ்",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.0),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 4),
              leading: Radio(
                value: BestTutorSite.tamil,
                groupValue: _site,
                activeColor: Colors.black,
                autofocus: true,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    _site = value!;
                    flag = 1;
                  });
                },
              ),
              tileColor: const Color.fromARGB(255, 245, 108, 108),
              title: const Text(
                "తెలుగు",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Color.fromARGB(255, 169, 208, 240),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 140, 255),
                  onPrimary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minimumSize: const Size(390, 50),
                ),
                onPressed: () {
                  route();
                },
                child: const Text("Next ->",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontSize: 17)))
          ],
        ),
      ),
    );
  }
}
