import 'dart:ui' as ui;

import 'package:drawing_app/presentation/bloc/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockImage extends Mock implements ui.Image {}

void main() {
  group('DrawingThicknessCubit', () {
    late DrawingThicknessCubit drawingThicknessCubit;

    setUp(() {
      drawingThicknessCubit = DrawingThicknessCubit();
    });

    tearDown(() {
      drawingThicknessCubit.close();
    });

    test('initial state is 4.0', () {
      expect(drawingThicknessCubit.state, 4.0);
    });

    test('changes thickness', () {
      drawingThicknessCubit.changeThickness(8.0);
      expect(drawingThicknessCubit.state, 8.0);
    });
  });

  group('BackgroundCubit', () {
    late BackgroundCubit backgroundCubit;

    setUp(() {
      backgroundCubit = BackgroundCubit();
    });

    tearDown(() {
      backgroundCubit.close();
    });

    test('initial state is white', () {
      expect(backgroundCubit.state, Colors.white);
    });

    test('changes background color', () {
      backgroundCubit.changeColor(Colors.blue);
      expect(backgroundCubit.state, Colors.blue);
    });
  });

  group('BackgroundImageCubit', () {
    late BackgroundImageCubit backgroundImageCubit;
    late MockImage mockImage;

    setUp(() {
      backgroundImageCubit = BackgroundImageCubit();
      mockImage = MockImage();
    });

    tearDown(() {
      backgroundImageCubit.close();
    });

    test('initial state is null', () {
      expect(backgroundImageCubit.state, null);
    });

    test('changes background image', () {
      backgroundImageCubit.changeImage(mockImage);
      expect(backgroundImageCubit.state, mockImage);
    });
  });
}
