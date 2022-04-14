import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HowToUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'How to use',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Steps',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'cascadia',
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              buildTimelineWidget(
                stepNumber: '1',
                text:
                    'In home screen select take a photo or choose from gallery option',
                context: context,
              ),
              buildTimelineWidget(
                stepNumber: '2',
                text: 'Select a clear closeup photo of the leaf like below',
                context: context,
                imagePath: 'assets/images/leafsample2.jpg',
              ),
              buildTimelineWidget(
                stepNumber: '3',
                text: 'Get the result!',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTimelineWidget({
    String stepNumber,
    String text,
    BuildContext context,
    String imagePath,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      afterLineStyle: LineStyle(color: Colors.blue),
      beforeLineStyle: LineStyle(color: Colors.blue),
      indicatorStyle: IndicatorStyle(color: Theme.of(context).accentColor),
      endChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'cascadia',
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              imagePath == null
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(imagePath),
                    ),
            ],
          ),
        ),
      ),
      startChild: Container(
        color: Colors.transparent,
        child: Center(
          child: Text(
            stepNumber,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontFamily: 'cascadia',
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
