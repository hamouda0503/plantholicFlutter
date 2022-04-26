
class Plant {
  static String HEIGHT = 'height';
  static String DIAMETER = 'diameter';
  static String MIN = 'min';
  static String MAX = 'max';

  Plant();

  String name;

  String category;
  bool toxic = false;
  Map<String, String> maxGrowth = {
    "diameter" : "40",
    "height" : "30",
  };
  Map<String, String> temperature = {
    "min" : "4",
    "max" : "24",
  };
  Map<String, String> airHumidity = {
    "min" : "25",
    "max" : "40",
  };
  Map<String, String> light = {
    "min" : "",
    "max" :"" ,
  };
  String lifespan = "";
  String soil;
  String watering ;
  String lightDuration;
  String image;


  Plant.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        category = json['category'],
        maxGrowth = {
          'diameter': json['maxGrowth'].split(',')[0] ,
          'height': json['maxGrowth'].split(',')[1] ,
        },
        temperature = {
          'min': json['temperature'].split(',')[0] ,
          'max': json['temperature'].split(',')[1] ,
        },
        airHumidity = {
          'min': json['airHumidity'].split(',')[0] ,
          'max': json['airHumidity'].split(',')[1] ,
        },
        light = {
          'min': json['light'].split(',')[0],
          'max': json['light'].split(',')[1],
        },
        soil = json['soil'],
        image = json['image'],
        watering = json['watering'],
        lightDuration = json['lightDuration'],
        lifespan = json['lifespan']
  ;

  Map<String, dynamic> toJson() =>
      {
        'name':name,
        'maxGrowth': maxGrowth,
        'temperature': temperature,
        'airHumidity': airHumidity,
        'soil': soil,
        'watering': watering,
        'light': light,
        'toxic': toxic,
        'lifespan': lifespan,
      };

}