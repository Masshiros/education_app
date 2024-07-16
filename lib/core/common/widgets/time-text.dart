import 'dart:async';
import 'package:education_app/core/extensions/date-time.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:flutter/material.dart';

class TimeText extends StatefulWidget {
  const TimeText(
    this.time, {
    super.key,
    this.prefixText,
    this.style,
    this.maxLines,
    this.overflow,
  });

  final DateTime time;
  final String? prefixText;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  State<TimeText> createState() => _TimeTextState();
}

class _TimeTextState extends State<TimeText> {
  Timer? timer;
  late String timeAgo;
  @override
  void initState() {
    super.initState();
    timeAgo = widget.time.timeAgo;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        if (timeAgo != widget.time.timeAgo) {
          setState(() {
            timeAgo = widget.time.timeAgo;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.prefixText != null ? '${widget.prefixText}' : ''} $timeAgo',
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      style: widget.style ??
          const TextStyle(
            fontSize: 12,
            color: Colours.neutralTextColour,
          ),
    );
  }
}
