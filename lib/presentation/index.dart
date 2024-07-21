import 'package:drawing_app/data/common/constants/sizes.dart';
import 'package:drawing_app/di/get_it.dart';
import 'package:drawing_app/presentation/bloc/cubits.dart';
import 'package:drawing_app/presentation/ui/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late DrawingColorCubit _drawingColorCubit;
  late DrawingThicknessCubit _drawingThicknessCubit;
  late BackgroundCubit _backgroundCubit;
  late BackgroundImageCubit _backgroundImageCubit;

  @override
  void initState() {
    super.initState();
    _drawingColorCubit = getItInstance<DrawingColorCubit>();
    _drawingThicknessCubit = getItInstance<DrawingThicknessCubit>();
    _backgroundCubit = getItInstance<BackgroundCubit>();
    _backgroundImageCubit = getItInstance<BackgroundImageCubit>();
  }

  @override
  void dispose() {
    _drawingColorCubit.close();
    _drawingThicknessCubit.close();
    _backgroundCubit.close();
    _backgroundImageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _drawingColorCubit),
        BlocProvider.value(value: _drawingThicknessCubit),
        BlocProvider.value(value: _backgroundCubit),
        BlocProvider.value(value: _backgroundImageCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 837),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          Sizes.init(context);
          return MaterialApp(
            title: 'Tomato Drawing App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const DrawingCanvas(),
          );
        },
      ),
    );
  }
}
