class Profile {
  final String? uid;
  final String? email;
  final String? name;

  Profile({
    required this.uid,
    required this.email,
    this.name,
  });
}

class Profiledata {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  Profiledata({this.uid, this.name, this.sugars, this.strength});
}
