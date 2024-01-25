import 'package:flutter/material.dart';
import 'package:lawer_finder/app.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/utils/theme/theme.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:lottie/lottie.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../utils/size/size.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isTyping = false;
  String _text = '';

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'done') {
            setState(() => _isListening = false);

            // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
            //   content: Text(_text),
            //   actions: [
            //     PText(
            //       text: "Your Voice",
            //       color: AppTheme.whiteColor,
            //     )
            //   ],
            //   backgroundColor: AppTheme.higlightColor,
            // ));
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {}
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: AppConstant.appName,
          fontSize: 24.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.whiteColor,
                radius: 35,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/lotties/logo-lottie.json',
                      height: sSize().height * 0.1,
                      width: sSize().height * 0.1,
                      fit: BoxFit.cover),
                ),
              ),
              box(10),
              PText(
                text: "Give Me Your Law :)",
                fontSize: 20.0,
                color: AppTheme.whiteColor,
              ),
              box(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: HomeCrimeTypeItem(
                        title: "Crime", subtitle: "Know Aboute Crime"),
                  ),
                  box(20),
                  const Expanded(
                    child: HomeCrimeTypeItem(
                        title: "Civil", subtitle: "Know Aboute Civil"),
                  ),
                ],
              ),
              box(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: HomeCrimeTypeItem(
                        title: "Family", subtitle: "Know Aboute Family"),
                  ),
                  box(20),
                  const Expanded(
                    child: HomeCrimeTypeItem(
                        title: "Property", subtitle: "Know Aboute Property"),
                  ),
                ],
              ),
              box(20),
              PText(
                text: _text,
                color: AppTheme.whiteColor,
              ),
              const Expanded(child: SizedBox()),
              bottomWidget()
            ],
          ),
        ),
      ),
    );
  }

  Container bottomWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 90),
      padding: const EdgeInsets.only(left: 15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppTheme.whiteColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(55))),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: TextEditingController(),
              autofocus: false,
              style: const TextStyle(color: AppTheme.whiteColor),
              maxLines: 5,
              minLines: 1,
              onChanged: ((value) {
                if (value.isEmpty) {
                  _isTyping = false;
                } else {
                  _isTyping = true;
                }
                setState(() {});
              }),
              cursorColor: AppTheme.higlightColor,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Type here....',
                  hintStyle: TextStyle(
                      color: AppTheme.whiteColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w200)),
            ),
          )),
          AvatarGlow(
            animate: _isTyping ? false : _isListening,
            glowColor: AppTheme.whiteColor,
            endRadius: 30.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: SizedBox(
              height: 40.0,
              child: FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: AppTheme.higlightColor,
                  onPressed: (() {
                    if (_isTyping) {
                      // chats.add(_chatController.text);
                      // _chatController.clear();
                      _isTyping = false;
                    } else {
                      _listen();
                    }
                    setState(() {});
                  }),
                  child: _isTyping
                      ? const Icon(Icons.send_outlined)
                      : SizedBox(
                          child: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            size: 30,
                          ),
                        )),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCrimeTypeItem extends StatelessWidget {
  const HomeCrimeTypeItem({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: themeData().primaryColor,
          border: Border.all(width: 1, color: AppTheme.whiteColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            text: title,
            color: AppTheme.whiteColor,
          ),
          box(4),
          PText(
            text: subtitle,
            color: AppTheme.whiteColor.withOpacity(0.5),
            fontSize: 10,
          )
        ],
      ),
    );
  }
}
