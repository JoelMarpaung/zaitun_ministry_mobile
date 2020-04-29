import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './map.dart';
import '../../model/info_find_us_model.dart';

class IndexInfo extends StatefulWidget {
  @override
  _IndexInfoState createState() => _IndexInfoState();
}

class _IndexInfoState extends State<IndexInfo> {
  int year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _infoHeader('About\n\n Us', 'images/backgrounds/welcome.png'),
            _aboutUsText(),
            _aboutUsGallery(1, 7),
            _gembalaProfile(),
            _aboutUsText2(),
            _aboutUsGallery(7, 13),
            Divider(),
            _infoHeader('Find\n\n Us', 'images/backgrounds/find.png'),
            _findUsGallery(),
            Divider(),
            _license(),
          ],
        ),
      ),
    );
  }

  Widget _infoHeader(String text, String image) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'PressStart2P',
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600),
          ),
          Image.asset(
            image,
            fit: BoxFit.fitWidth,
            width: 120,
          ),
        ],
      ),
    );
  }

  Widget _aboutUsGallery(int first, int last) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = first; i < last; i++) ...[
                Image.asset(
                  'images/backgrounds/$i.jpg',
                  fit: BoxFit.fitWidth,
                  height: 120,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutUsText() {
    return Card(
      color: Colors.yellow.shade100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              'RADIO ZAITUN beralamat di jalan Lumban Dolok, Balige, Kabupaten Toba, Sumatera Utara, Indonesia.\n\n' +
                  'ON AIR mulai dari pukul 05.00 pagi sampai dengan pukul 23.00 malam, dengan membawa lagu, khotbah, hingga talkshow full rohani.',
              style: TextStyle(fontFamily: 'Kalam'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton.icon(
                color: Colors.amber.shade900,
                label: Text(
                  'Visit Us',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(
                  Icons.airplanemode_active,
                  size: 20,
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Map(),
                    fullscreenDialog: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gembalaProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Card(
            color: Colors.blue.shade100,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Pdt. Thamrin Simanjuntak, S.Th. adalah Bapak Gembala Sidang di Zaitun Ministry.',
                style: TextStyle(fontFamily: 'Kalam'),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  maxRadius: 70,
                  backgroundImage: AssetImage('images/backgrounds/profile.jpg'),
                ),
              ),
            ),
            onTap: () async {
              if (await canLaunch(
                  "https://www.instagram.com/thamrin_simanjuntak/")) {
                await launch("https://www.instagram.com/thamrin_simanjuntak/");
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _aboutUsText2() {
    return Card(
      color: Colors.yellow.shade100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          'Hingga saat ini sudah ada beberapa cabang gereja selain dari Zaitun yang berlokasi di Balige, yaitu Lubuk Pakam, Binjai, Parapat, Porsea, Siborong-borong dan Samosir. \n\n'+ 
          'Di Zaitun diadakan beberapa kegiatan ibadah seperti ibadah raya, ibadah muda mudi, ibadah sekolah minggu, ibadah pelepasan dan kesembuhan ilahi, ' +
              'ibadah pendalaman alkitab, ibadah mezbah dupa, ibadah fellowship, dan kegiatan ibadah lainnya.',
          style: TextStyle(fontFamily: 'Kalam'),
        ),
      ),
    );
  }

  Widget _findUsGallery() {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              for (MapEntry item in findUsData.entries) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var content in item.value) ...[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Image.asset(
                              content['image'],
                              width: 80,
                            ),
                            onTap: () async {
                              if (await canLaunch(content['link'])) {
                                await launch(content['link']);
                              }
                            },
                          ),
                          Text(
                            content['text'],
                            style: TextStyle(fontFamily: 'Acme'),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
              ],
            ],
          )),
    );
  }

  Widget _license() {
    return new Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
                "Radio Zaitun mobile application is designed and built by Zaitun Application Developer.\n"),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Copyright \u00a9"),
                new Text(" $year"),
                new Text(" Radio Zaitun."),
                new Text(" All rights reserved.")
              ],
            ),
          ),
          new Text("All credits are shown here for assets licensing."),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: RichText(
                  text: TextSpan(children: [
                    new TextSpan(
                      text: "1. Vector Illustrator ",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    new TextSpan(
                      text: "(icons8.com)",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff297cbb),
                      ),
                    )
                  ]),
                ),
                onTap: () async {
                  if (await canLaunch("https://icons8.com/ouch")) {
                    await launch("https://icons8.com/ouch");
                  }
                },
              ),
              InkWell(
                child: RichText(
                  text: TextSpan(children: [
                    new TextSpan(
                      text: "2. Icons ",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    new TextSpan(
                      text: "(icons8.com/icons)",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff297cbb),
                      ),
                    )
                  ]),
                ),
                onTap: () async {
                  if (await canLaunch("https://icons8.com/icons")) {
                    await launch("https://icons8.com/icons");
                  }
                },
              ),
              InkWell(
                child: RichText(
                  text: TextSpan(children: [
                    new TextSpan(
                      text: "3. Fonts ",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    new TextSpan(
                      text: "(fonts.google.com)",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff297cbb),
                      ),
                    )
                  ]),
                ),
                onTap: () async {
                  if (await canLaunch("fonts.google.com")) {
                    await launch("fonts.google.com");
                  }
                },
              ),
            ],
          ),
          Text('\nApp. version 1.0.1'),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
          ),
        ],
      ),
    );
  }
}
