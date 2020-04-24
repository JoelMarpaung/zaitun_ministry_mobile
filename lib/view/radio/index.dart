import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../../controller/audio_player_task_controller.dart';

class IndexRadio extends StatefulWidget {
  @override
  _IndexRadioState createState() => _IndexRadioState();
}

class _IndexRadioState extends State<IndexRadio> {
  bool isButtonDisabled = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<ScreenState>(
        stream: _screenStateStream,
        builder: (context, snapshot) {
          final screenState = snapshot.data;
          final state = screenState?.playbackState;
          final basicState = state?.basicState ?? BasicPlaybackState.none;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              logo(),
              middle(basicState),
              Text(
                "Mohon tunggu sampai radio menyala !",
                style: TextStyle(color: Colors.red),
              ),
              quotes(),
            ],
          );
        },
      ),
    );
  }

  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));

  RaisedButton audioPlayerButton() => startButton(
        'Listen Radio',
        () {
          AudioService.start(
            backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
            androidNotificationChannelName: 'Zaitun Ministry Radio',
            notificationColor: 0xFF2196f3,
            androidNotificationIcon: 'mipmap/ic_launcher',
            enableQueue: true,
          );
        },
      );

  RaisedButton startButton(String label, VoidCallback onPressed) =>
      RaisedButton.icon(
        autofocus: true,
        color: Colors.yellow.shade900,
        label: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        icon: Icon(
          Icons.headset,
          size: 20,
        ),
        onPressed: () {
          if (!isButtonDisabled) {
            setState(() {
              isButtonDisabled = true;
            });
            onPressed();
          }
        },
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      );

  RaisedButton stopButton() => RaisedButton.icon(
        autofocus: true,
        color: Colors.red.shade900,
        label: Text(
          'Stop Listen',
          style: TextStyle(fontSize: 20),
        ),
        icon: Icon(
          Icons.headset_off,
          size: 20,
        ),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        onPressed: () {
          setState(() {
            isButtonDisabled = false;
          });
          AudioService.stop();
        },
      );

  Container logo() => Container(
        padding: EdgeInsets.all(5),
        child: Image.asset(
          'images/logos/zaitun_logo_dark.jpg',
          fit: BoxFit.cover,
        ),
      );

  Container middle(var stat) => Container(
        child: Card(
          color: Colors.blue.shade400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipPath(
                clipper: ArcClipperLeft(),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Container(
                    color: Colors.amber.shade500,
                  ),
                ),
              ),
              if (stat == BasicPlaybackState.none)
                audioPlayerButton()
              else
                stopButton(),
              ClipPath(
                clipper: ArcClipperRight(),
                child: SizedBox(
                  width: 70,
                  height: 100,
                  child: Container(
                    color: Colors.amber.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Container quotes() => Container(
        child: Card(
          color: Colors.amber.shade200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(
                  Icons.book,
                  size: 80,
                  color: Colors.black87,
                ),
                title: Text('But I and my family will worship the Lord!',
                    style: TextStyle(
                      fontSize: 31,
                      fontFamily: 'GochiHand',
                    )),
                subtitle: Text(
                  'Joshua 24:15',
                  style: TextStyle(fontFamily: 'Acme'),
                ),
              ),
            ],
          ),
        ),
      );
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class ArcClipperLeft extends CustomClipper<Path> {
  @override

  //ATTRIBUTE INI YANG AKAN MENJADI TEMPAT KITA MENDESAIN SETIAP SUDUTNYA
  Path getClip(Size size) {
    var path = Path(); //INISIASI PATHNYA TERLEBIH DAHULU
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.width / 2, size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArcClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width, size.width / 2, 0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
