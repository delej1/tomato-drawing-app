import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// Cubit for managing drawing color
class DrawingColorCubit extends Cubit<Color> {
  DrawingColorCubit() : super(Colors.black);

  void changeColor(Color color) {
    emit(color);
  }
}

// Cubit for managing drawing thickness
class DrawingThicknessCubit extends Cubit<double> {
  DrawingThicknessCubit() : super(4.0);

  void changeThickness(double thickness) {
    emit(thickness);
  }
}

// Cubit for managing background color
class BackgroundCubit extends Cubit<Color> {
  BackgroundCubit() : super(Colors.white);

  void changeColor(Color color) {
    emit(color);
  }
}

// Cubit for managing background image
class BackgroundImageCubit extends Cubit<ui.Image?> {
  BackgroundImageCubit() : super(null);

  void changeImage(ui.Image? image) {
    emit(image);
  }
}