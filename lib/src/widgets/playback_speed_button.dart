// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../enums/playback_rate.dart';
import '../utils/youtube_player_controller.dart';

/// A widget to display playback speed changing button.
class PlaybackSpeedButton extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController controller;

  /// Defines icon for the button.
  final Widget icon;

  /// Creates [PlaybackSpeedButton] widget.
  const PlaybackSpeedButton({
    this.controller,
    this.icon,
  });

  @override
  _PlaybackSpeedButtonState createState() => _PlaybackSpeedButtonState();
}

class _PlaybackSpeedButtonState extends State<PlaybackSpeedButton> {
  YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = YoutubePlayerController.of(context);
    if (_controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      color: Colors.black54,
      onSelected: (rate) {
        _controller.setPlaybackRate(rate);
        _controller.updateValue(_controller.value.copyWith(playbackRate: rate));
        if (mounted) setState(() {});
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: widget.icon ??
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5)),
                padding: EdgeInsets.only(
                  right: 3,
                  left: 3,
                  top: 1,
                  bottom: 2,
                ),
                child: Text(
                  '${_controller.value.playbackRate.toString()}x',
                  style: TextStyle(fontSize: 12),
                ),
              ) /* Image.asset(
              'assets/speedometer.webp',
              package: 'youtube_player_flutter',
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ), */
          ),
      tooltip: 'PlayBack Rate',
      itemBuilder: (context) => [
        _popUpItem('2.0x', PlaybackRate.twice),
        _popUpItem('1.75x', PlaybackRate.oneAndAThreeQuarter),
        _popUpItem('1.5x', PlaybackRate.oneAndAHalf),
        _popUpItem('1.25x', PlaybackRate.oneAndAQuarter),
        _popUpItem('Normal', PlaybackRate.normal),
        _popUpItem('0.75x', PlaybackRate.threeQuarter),
        _popUpItem('0.5x', PlaybackRate.half),
        _popUpItem('0.25x', PlaybackRate.quarter),
      ],
    );
  }

  Widget _popUpItem(String text, double rate) {
    return PopupMenuItem(
      child: Text(text),
      value: rate,
    );
  }
}
