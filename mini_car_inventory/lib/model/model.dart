class Model {
  int id;
  String manufacturer_name;
  String name;
  String color;
  String regno;
  String year;
  String note;
  int count;
  String pic;
  String is_sold;

  Model(
      {this.id,
      this.manufacturer_name,
      this.name,
      this.color,
      this.note,
      this.pic,
      this.regno,
      this.count,
      this.year,});

  factory Model.fromDatabaseJson(Map<String, dynamic> data) => Model(
        //Factory method will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Model object

        id: data['id'],
        manufacturer_name: data['manufacturer_name'],
        name: data['name'],
        year: data['year'],
        color: data['color'],
        regno: data['regno'],
        note: data['note'],
        count: data['count'],
        pic: data['pic'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        //A method will be used to convert Model objects that
        //are to be stored into the datbase in a form of JSON
        "manufacturer_name": this.manufacturer_name,
        "name": this.name,
        "year": this.year,
        "color": this.color,
        "regno": this.regno,
        "note": this.note,
        "count": this.count,
        "pic": this.pic,
      };
}
