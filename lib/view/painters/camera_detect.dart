// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
//
// class CameraApp extends StatefulWidget {
//   final CameraDescription camera;
//
//   const CameraApp({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);
//
//   @override
//   _CameraAppState createState() => _CameraAppState();
// }
//
// class _CameraAppState extends State<CameraApp> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   final ObjectDetector _objectDetector = GoogleMlKit.vision.objectDetector(
//     options: ObjectDetectorOptions(
//       multipleObjects: true,
//       mode: DetectionMode.stream,
//       classifyObjects: true,
//     ),
//   );
//
//   List<DetectedObject> _detectedObjects = [];
//   double _zoomLevel = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize().then((_) {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Auto Zoom Camera'),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 CameraPreview(_controller),
//                 CustomPaint(
//                   painter: BoundingBoxPainter(_detectedObjects, _controller),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.camera_alt),
//         onPressed: () async {
//           await _takePicture();
//         },
//       ),
//     );
//   }
//
//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;
//       final XFile image = await _controller.takePicture();
//       final inputImage = InputImage.fromFilePath(image.path);
//       final List<DetectedObject> objects = await _objectDetector.processImage(inputImage);
//       setState(() {
//         _detectedObjects = objects;
//       });
//     } catch (e) {
//       print('Error taking picture: $e');
//     }
//   }
// }
//
// class BoundingBoxPainter extends CustomPainter {
//   final List<DetectedObject> detectedObjects;
//   final CameraController controller;
//
//   BoundingBoxPainter(this.detectedObjects, this.controller);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..color = Colors.green;
//
//     for (var object in detectedObjects) {
//       final left = size.width * object.boundingBox.left;
//       final top = size.height * object.boundingBox.top;
//       final right = size.width * object.boundingBox.right;
//       final bottom = size.height * object.boundingBox.bottom;
//       canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
