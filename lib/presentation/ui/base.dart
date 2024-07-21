import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:drawing_app/data/common/constants/sizes.dart';
import 'package:drawing_app/presentation/bloc/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:image_picker/image_picker.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();
  bool isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: isFullscreen
            ? null
            : AppBar(
                leading: Padding(
                  padding:
                      const EdgeInsets.all(8.0), // Adjust padding as needed
                  child: Image.asset(
                    'assets/images/tomato.png',
                  ),
                ),
                title: const Center(child: Text('Drawing Canvas')),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.fullscreen),
                    onPressed: () {
                      setState(() {
                        isFullscreen = true;
                      });
                    },
                  ),
                ],
              ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<BackgroundCubit, Color>(
                builder: (context, backgroundColor) {
                  return BlocBuilder<BackgroundImageCubit, ui.Image?>(
                    builder: (context, backgroundImage) {
                      return Container(
                        color: backgroundColor,
                        child: Stack(
                          children: [
                            if (backgroundImage != null)
                              CustomPaint(
                                size: Size.infinite,
                                painter: BackgroundImagePainter(
                                    image: backgroundImage),
                              ),
                            BlocBuilder<DrawingColorCubit, Color>(
                              builder: (context, drawColor) {
                                return BlocBuilder<DrawingThicknessCubit,
                                    double>(
                                  builder: (context, strokeWidth) {
                                    return Signature(
                                      key: _signatureKey,
                                      color: drawColor,
                                      strokeWidth: strokeWidth,
                                    );
                                  },
                                );
                              },
                            ),
                            if (isFullscreen)
                              Positioned(
                                top: Sizes.dimen_5.h,
                                right: Sizes.dimen_5.w,
                                child: IconButton(
                                  icon: const Icon(Icons.fullscreen_exit,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      isFullscreen = false;
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (!isFullscreen)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _signatureKey.currentState?.clear();
                      context.read<BackgroundImageCubit>().changeImage(null);
                    },
                  ),
                  PopupMenuButton<Color>(
                    icon: const Icon(Icons.color_lens),
                    onSelected: (Color color) {
                      context.read<DrawingColorCubit>().changeColor(color);
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<Color>(
                          value: Colors.black,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.black),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Black"),
                            ],
                          ),
                        ),
                        PopupMenuItem<Color>(
                          value: Colors.red,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.red),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Red"),
                            ],
                          ),
                        ),
                        PopupMenuItem<Color>(
                          value: Colors.green,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.green),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Green"),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                  PopupMenuButton<Color>(
                    icon: const Icon(Icons.format_color_fill),
                    onSelected: (Color color) {
                      context.read<BackgroundCubit>().changeColor(color);
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<Color>(
                          value: Colors.white,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.white),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("White"),
                            ],
                          ),
                        ),
                        PopupMenuItem<Color>(
                          value: Colors.yellow,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.yellow),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Yellow"),
                            ],
                          ),
                        ),
                        PopupMenuItem<Color>(
                          value: Colors.blue,
                          child: Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.blue),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Blue"),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                  PopupMenuButton<double>(
                    icon: const Icon(Icons.brush),
                    onSelected: (double strokeWidth) {
                      context
                          .read<DrawingThicknessCubit>()
                          .changeThickness(strokeWidth);
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<double>(
                          value: 2.0,
                          child: Row(
                            children: [
                              const Icon(Icons.brush, size: 2.0),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Thin"),
                            ],
                          ),
                        ),
                        PopupMenuItem<double>(
                          value: 4.0,
                          child: Row(
                            children: [
                              const Icon(Icons.brush, size: 4.0),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Normal"),
                            ],
                          ),
                        ),
                        PopupMenuItem<double>(
                          value: 8.0,
                          child: Row(
                            children: [
                              const Icon(Icons.brush, size: 8.0),
                              SizedBox(width: Sizes.dimen_8.w),
                              const Text("Thick"),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (context.mounted && image != null) {
                        final loadedImage = await _loadImage(
                            image.path, MediaQuery.of(context).size);
                        if (context.mounted) {
                          context
                              .read<BackgroundImageCubit>()
                              .changeImage(loadedImage);
                        }
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image> _loadImage(String path, Size screenSize) async {
    // Read the image file as bytes
    final Uint8List bytes = await File(path).readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    final ui.Image originalImage = await completer.future;

    // Calculate scale to maintain aspect ratio
    double scale = screenSize.width / originalImage.width;
    if (originalImage.height * scale > screenSize.height) {
      scale = screenSize.height / originalImage.height;
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // Draw the image centered and scaled
    canvas.drawImageRect(
      originalImage,
      Rect.fromLTWH(0, 0, originalImage.width.toDouble(),
          originalImage.height.toDouble()),
      Rect.fromLTWH(
        (screenSize.width - originalImage.width * scale) / 2,
        (screenSize.height - originalImage.height * scale) / 2,
        originalImage.width * scale,
        originalImage.height * scale,
      ),
      paint,
    );
    final ui.Picture picture = recorder.endRecording();
    final ui.Image croppedImage = await picture.toImage(
        screenSize.width.toInt(), screenSize.height.toInt());

    return croppedImage;
  }
}

class BackgroundImagePainter extends CustomPainter {
  final ui.Image image;

  BackgroundImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
