class Manufacturer {
  int id;
  String name;

  Manufacturer({this.id, this.name});


  factory Manufacturer.fromDatabaseJson(Map<String, dynamic> data) => Manufacturer(
    //Factory method will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Manufacturer object

        id: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
    //A method will be used to convert Manufacturer objects that
    //are to be stored into the datbase in a form of JSON
        "name": this.name,
      };
}
