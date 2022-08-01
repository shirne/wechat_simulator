import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme();

  const AppTheme.light();

  const AppTheme.dark();

  @override
  ThemeExtension<AppTheme> copyWith() {
    return const AppTheme();
  }

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    return other ?? this;
  }
}
