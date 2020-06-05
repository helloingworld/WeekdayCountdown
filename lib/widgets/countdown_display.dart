// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weekday_countdown/common/app_settings.dart';
import 'package:weekday_countdown/utils/utils.dart';

/// A widget that displays a centered integer counter value, filled with a specified color.
class CountdownDisplay extends StatelessWidget {
  /// Creates a counter display widget.
  const CountdownDisplay({
    Key key,
    @required this.countdown,
    @required this.countdownFormat,
    @required this.color,
    this.isPortrait = true,
  })  : assert(color != null),
        assert(isPortrait != null),
        super(key: key);

  /// The color with which to fill the counter container.
  final Color color;

  /// Are we in portrait "mode"?
  final bool isPortrait;

  final Duration countdown;

  final CountdownFormat countdownFormat;

  @override
  Widget build(BuildContext context) {
    final TextStyle counterStyle =
        isPortrait ? Theme.of(context).textTheme.headline1 : Theme.of(context).textTheme.headline2;

    final bool hasUnits = (countdown != null && countdownFormat != CountdownFormat.duration);

    return Container(
      alignment: Alignment.center,
      color: color,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              countdown == null ? 'Today' : formatCountdown(context, countdown, countdownFormat),
              overflow: TextOverflow.ellipsis,
              style: counterStyle.copyWith(
                color: color.contrastOf(),
              ),
            ),
          ),
          if (hasUnits)
            Text(
              describeEnum(countdownFormat),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: color.contrastOf(),
                  ),
            ),
        ],
      ),
    );
  }
}
