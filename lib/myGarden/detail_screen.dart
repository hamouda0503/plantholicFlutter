import 'dart:convert';
import 'package:flutter/material.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:plantholic/myGarden/Modelo/plant_info.dart';

import 'package:plantholic/myGarden/core/app_text_styles.dart';
import 'package:plantholic/myGarden/my_plants/my_plants_controller.dart';

import 'package:plantholic/myGarden/widgets/watering_plant/watering_plant_widget.dart';
import 'package:plantholic/myGarden/my_plants/my_plants.dart';


import '../app_colors.dart';

class PlantDetailsPage extends StatefulWidget {
  final MyPlant plant;

  PlantDetailsPage({
    Key key,
    @required this.plant,
  }) : super(key: key);

  @override
  State<PlantDetailsPage> createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage> {


    final MyPlantsController _myPlantsController =MyPlantsController();
        
  MyPlant planty;
  TimeOfDay selectTimeData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectTimeData = TimeOfDay.fromDateTime(DateTime.parse(widget.plant.nextWaterDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Grey,
        iconTheme: IconThemeData(color: AppColors.Blue),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(32.0),
                  height: 390.0,
                  decoration: BoxDecoration(
                    color: AppColors.Grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.plant.image == null
                          ? SizedBox()
                          : Image.memory(
                              base64.decode(widget.plant.image),
                              height: 200,
                            ),
                      Text(
                        widget.plant.nickname,
                        style: AppTextStyles.heading24,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        widget.plant.specie,
                        style: AppTextStyles.bodyDark,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                WateringPlantWidget(
                  title: "Keep the soil always moist without waterlogging. Water every "+widget.plant.waterCycle+" days. with" + widget.plant.nextWater +" ml of water",
                  marginTop: -45.0,
                ),
                Text(
                  'Choose the best time to be remembered : ',
                  style: AppTextStyles.bodyDark,
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () => selectTime(context),
                  child: Container(
                    height: 32.0,
                    width: 260.0,
                    decoration: BoxDecoration(
                      color: AppColors.shape,
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.shape.withOpacity(.5),
                          AppColors.blueLight.withOpacity(.5),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.Grey,
                          blurRadius: 10.0,
                          offset: Offset(-5.0, 10.0),
                        ),
                        BoxShadow(
                          color: AppColors.Grey,
                          blurRadius: 10.0,
                          offset: Offset(10.0, -10.0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${selectTimeData.hour} horas',
                          style: AppTextStyles.bodyDark,
                        ),
                        Text(
                          '${selectTimeData.minute} min',
                          style: AppTextStyles.bodyDark,
                        ),
                        Text(
                          '0 seg',
                          style: AppTextStyles.bodyDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(32.0),
              child: Container(
                height: 56.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // scheduleNotification(selectTimeData);
                    if (!_myPlantsController.checkPlantAlreadyExists(widget.plant)) {
                    _myPlantsController.handleAddNewPlant(
                      widget.plant,
                      DateTime.parse(widget.plant.nextWaterDate),
                    );
                    print(_myPlantsController.myPlants);
                  }
                  if (_myPlantsController.checkPlantAlreadyExists(widget.plant)) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPlants()));
                    print(_myPlantsController.myPlants);
                  }
                },
                  
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.Green,
                    ),
                  ),
                  child: Text(
                    'Campo inválido, tente novamente',
                    style: AppTextStyles.textButton,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.Grey,
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    var picked = await showTimePicker(
        context: context,
        initialTime: selectTimeData,
        helpText: 'Selecione um horário',
        confirmText: 'SALVAR',
        cancelText: 'CANCELAR',
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              accentColor: AppColors.Green,
              colorScheme: ColorScheme.light(
                primary: AppColors.Green,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white,
                helpTextStyle: AppTextStyles.bodyDark,
                dayPeriodColor: Colors.white,
                dayPeriodTextColor: AppColors.Green,
                dayPeriodTextStyle: AppTextStyles.bodyDark,
                dialBackgroundColor: AppColors.GreenA,
                entryModeIconColor: AppColors.Grey,
                hourMinuteTextColor:
                    AppColors.Green, // Número dentro do quadrado
                hourMinuteColor:
                    AppColors.GreenA, // Quadrado dentro dos números
                dialHandColor: Colors.white,
                dialTextColor: AppColors.Green,
              ),
            ),
            child: child,
          );
        });

    if (picked != null) {
      selectTimeData = picked;
    }
  }

  // void scheduleNotification(TimeOfDay alert) async {
  //   DateTime time = DateTime.parse(widget.plant.nextWaterDate);
  //   var scheduleNotificationDataTime = DateTime(
  //     time.year,
  //     time.month,
  //     time.day,
  //     alert.hour,
  //     alert.minute,
  //   );

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'plant_notif',
  //     'plant_notif',
  //     'Channel for plant notfication',
  //     icon: 'ic_launcher',
  //     largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
  //     sound: RawResourceAndroidNotificationSound(''),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //     sound: '',
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );

  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   await FlutterLocalNotificationsPlugin().schedule(
  //     0,
  //     'plantholic',
  //     'es9ini',
  //     scheduleNotificationDataTime,
  //     platformChannelSpecifics,
  //   );
  // }
}
