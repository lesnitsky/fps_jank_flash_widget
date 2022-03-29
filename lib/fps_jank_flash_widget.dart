import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A [ChangeNotifier] that invokes listeners if a frame exceeds a budget
/// defined in [FPSJankFlash.frameBudget].
class JankObserver extends ChangeNotifier {
  static final JankObserver _instance = JankObserver._();
  factory JankObserver() => _instance;

  JankObserver._() {
    SchedulerBinding.instance!.addPersistentFrameCallback(_onFrame);
  }

  Duration? _prevDuration;

  void _onFrame(Duration frameDuration) {
    if (_prevDuration != null) {
      final duration = frameDuration - _prevDuration!;

      if (duration > FPSJankFlash.frameBudget) {
        notifyListeners();
      }
    }
    _prevDuration = frameDuration;
  }
}

class FPSJankFlash extends StatefulWidget {
  /// Time budget for the frame to be painted.
  /// If the frame takes longer than this, you will see a flash.
  static Duration frameBudget = const Duration(milliseconds: 17);

  /// The color of the flash.
  final Color? flashColor;

  const FPSJankFlash({
    Key? key,
    this.flashColor = const Color(0x00ff0000),
  }) : super(key: key);

  @override
  State<FPSJankFlash> createState() => _FPSJankFlashState();
}

class _FPSJankFlashState extends State<FPSJankFlash> {
  final observer = JankObserver();
  bool flash = false;

  @override
  void initState() {
    observer.addListener(() {
      setState(() {
        flash = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (flash) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {
          flash = false;
        });
      });
    }

    return IgnorePointer(
      ignoring: true,
      child: Container(
        color: flash ? Colors.red : Colors.transparent,
        child: const SizedBox.expand(),
      ),
    );
  }
}
