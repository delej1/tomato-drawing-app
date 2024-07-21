import 'package:drawing_app/presentation/bloc/cubits.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

final getItInstance = GetIt.I;

Future init() async {
  final ImagePicker imagePicker = ImagePicker();

  ///IMAGE PICKER
  getItInstance.registerSingleton<ImagePicker>(imagePicker);

  ///CUBITS
  // DRAWING COLOR CUBIT
  getItInstance.registerFactory(() => DrawingColorCubit());

  // DRAWING THICKNESS CUBIT
  getItInstance.registerFactory(() => DrawingThicknessCubit());

  // BACKGROUND COLOR CUBIT
  getItInstance.registerFactory(() => BackgroundCubit());

  // BACKGROUND IMAGE CUBIT
  getItInstance.registerFactory(() => BackgroundImageCubit());
}