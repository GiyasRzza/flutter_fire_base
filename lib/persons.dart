class Persons{
  String personName;
  int personAge;

  Persons(this.personName, this.personAge);

  factory Persons.fromJson(Map<dynamic,dynamic> json){
    return Persons(json["person_name"].toString(), json["person_age"] as int);
  }
}