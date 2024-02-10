import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/utils/theme/theme.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:lottie/lottie.dart';
import '../../utils/size/size.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";
  final TextEditingController _textController = TextEditingController();

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  @override
  void initState() {
    super.initState();
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _textController.text = _lastWords;
    });
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.whiteColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FloatingActionButton.small(
                      onPressed:
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? _startListening
                              : _stopListening,
                      tooltip: 'Listen',
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        _speechToText.isNotListening
                            ? Icons.mic_off
                            : Icons.mic,
                        color: Colors.amber,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
          // AvatarGlow(
          //   animate: _isTyping ? false : _isListening,
          //   glowColor: AppTheme.whiteColor,
          //   endRadius: 30.0,
          //   duration: const Duration(milliseconds: 2000),
          //   repeatPauseDuration: const Duration(milliseconds: 100),
          //   repeat: true,
          //   child: SizedBox(
          //     height: 40.0,
          //     child: FloatingActionButton(
          //         elevation: 0.0,
          //         backgroundColor: AppTheme.higlightColor,
          //         onPressed: (() {
          //           if (_isTyping) {
          //             // chats.add(_chatController.text);
          //             // _chatController.clear();
          //             _isTyping = false;
          //           } else {
          //             _listen();
          //           }
          //           setState(() {});
          //         }),
          //         child: _isTyping
          //             ? const Icon(Icons.send_outlined)
          //             : SizedBox(
          //                 child: Icon(
          //                   _isListening ? Icons.mic : Icons.mic_none,
          //                   size: 30,
          //                 ),
          //               )),
          //   ),
          // ),
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
