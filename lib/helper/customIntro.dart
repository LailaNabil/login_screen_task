import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

Intro intro = Intro(

  /// You can set it true to disable animation
  noAnimation: false,

  /// The total number of guide pages, must be passed
  stepCount: 6,

  /// Click on whether the mask is allowed to be closed.
  maskClosable: false,

  /// When highlight widget is tapped.
  onHighlightWidgetTap: (introStatus) {
    print(introStatus);
  },

  /// The padding of the highlighted area and the widget
  padding: EdgeInsets.all(8),

  /// Border radius of the highlighted area
  borderRadius: BorderRadius.all(Radius.circular(4)),

  /// Use the default useDefaultTheme provided by the library to quickly build a guide page
  /// Need to customize the style and content of the guide page, implement the widgetBuilder method yourself
  /// * Above version 2.3.0, you can use useAdvancedTheme to have more control over the style of the widget
  /// * Please see https://github.com/tal-tech/flutter_intro/issues/26
  widgetBuilder: StepWidgetBuilder.useDefaultTheme(

    /// Guide page text
    texts: [
      'Change Language from here',
      'Enter phone number to login here',
      'Enter password to login/sign up here',
      'After entering phone number and password,press here to submit',
      'To switch to sign up mode,press here',
      'In case you forgot your password,press here',
    ],

    /// Button text
    buttonTextBuilder: (curr, total) {
      return curr < total - 1 ? 'Next' : 'Finish';
    },
  ),
);