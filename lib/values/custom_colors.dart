import 'package:flutter/material.dart';

class CustomColors {
  Color _activePrimaryButton = Color.fromARGB(255, 63, 81, 181);
  Color _activeSecondaryButton = Color.fromARGB(255, 95, 255, 98);
  Color _gradientMainColor = Colors.green;
  Color _gradienteSecColor = Color.fromARGB(255, 212, 247, 255);

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getActiveSecondaryButtonColor() {
    return _activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return _gradientMainColor;
  }

  Color getGradienteSecColor() {
    return _gradienteSecColor;
  }
}
