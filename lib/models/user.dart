class Profile {
  final String? uid;
  final String? email;

  Profile({
    required this.uid,
    required this.email,
  });
}

class Profiledata {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  Profiledata({this.uid, this.name, this.sugars, this.strength});
}
