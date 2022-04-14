import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantholic/app_colors.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
class ARViewScreen extends StatefulWidget {
  const ARViewScreen({Key key,this.pic}) : super(key: key);
  final String pic ;

  @override
  _ARViewScreenState createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  ArCoreController arCoreController;

  void whenArCoreViewCreared(ArCoreController controller){
      arCoreController =controller;
      arCoreController.onPlaneTap=controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> result){
    final hit=result.first;
    addItemImagetoScene(hit);
  }

  Future addItemImagetoScene(ArCoreHitTestResult hitTestResult) async{
    final bytes = (await rootBundle.load(widget.pic)).buffer.asUint8List();

    final imageItem = ArCoreNode(
      image: ArCoreImage(bytes: bytes,width: 600,height: 600),
      position: hitTestResult.pose.translation+ vector.Vector3(0.0,0.0,0.0),
      rotation: hitTestResult.pose.rotation+ vector.Vector4(0.0,0.0,0.0,0.0),
    );

    arCoreController.addArCoreNodeWithAnchor(imageItem);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.Grey,
      // ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreared,
        enableTapRecognizer: true,
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
