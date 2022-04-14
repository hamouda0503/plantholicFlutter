import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:plantholic/app_colors.dart';
import './k_drawer.dart';
import '../how_to_use/how_to_use.dart';
import '../image_view_page/image_view_page.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  File image;
  List output;

  @override
  void initState() {
    loadModel().then((value) {
      setState(() {});
    });
    super.initState();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/plant_disease_model.tflite',
      labels: 'assets/plant_labels.txt',
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage(ImageSource source) async {
    var chosenImage = await picker.getImage(source: source);

    if (chosenImage == null) return null;

    setState(() {
      image = File(chosenImage.path);
    });

    classifyImage(image);
  }

  classifyImage(File image) async {
    var tfOutput = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      imageMean: 0,
      imageStd: 255,
      threshold: 0.4,
    );
    print(tfOutput);

    setState(() {
      output = tfOutput;
      print(output);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    buildBottomPanelButton({
      BuildContext context,
      String text,
      Function onTap,
      double buttonHeight,
      double buttonWidth,
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: AppColors.Green,
          onTap: onTap,
          child: Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.Green,
                width: 2,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.Green,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    buildBottomPanel({
      @required double height,
      @required double width,
    }) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text('Check plant condition using image',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                color: AppColors.Green,
              )),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBottomPanelButton(
                context: context,
                text: 'Take a photo',
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                buttonHeight: height * 0.11,
                buttonWidth: width * 0.4,
              ),
              SizedBox(width: width * 0.02),
              buildBottomPanelButton(
                context: context,
                text: 'Choose from gallery',
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
                buttonHeight: height * 0.11,
                buttonWidth: width * 0.4,
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      );
    }

    buildAnalyzedText(String group, String result) {
      return RichText(
        text: TextSpan(
          text: group,
          style: TextStyle(
            color: AppColors.Green,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: result.toUpperCase(),
              style: TextStyle(
                color: AppColors.Green,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    }

    buildClassifiedColumn() {
      String label;
      List<String> result;
      String plantType;
      String condition;
      double confidence;
      if (output != null && output.isNotEmpty) {
        label = output.first['label'];
        result = label.split(' ');
        confidence = output.first['confidence'] * 100;
        plantType = result[0];
        condition = label.replaceAll('$plantType ', '');
      }

      return Padding(
        padding: const EdgeInsets.all(34),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAnalyzedText('Plant Type: ', plantType ?? 'ERROR'),
                    buildAnalyzedText('Condition : ', condition ?? 'ERROR'),
                    buildAnalyzedText(
                      'Confidence: ',
                      '${confidence == null ? 'ERROR' : confidence.ceil().toString()}%',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -2,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Analysis',
                    style: TextStyle(
                      color: AppColors.Green,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      drawer: KDrawer(),
      appBar: AppBar(
        title: Text(
          'Plant Disease Detector',
          style: TextStyle(color: AppColors.Green),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  image == null
                      ? Lottie.asset(
                          'assets/animations/home_plant.json',
                          animate: true,
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageViewPage(image),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 34),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                image,
                                height: height * 0.37,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  output != null ? buildClassifiedColumn() : Container(),
                ],
              ),
            ),
            Spacer(),
            Container(
              //height: height * 0.25,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: buildBottomPanel(height: height, width: width),
            ),
          ],
        ),
      ),
    );
  }
}
