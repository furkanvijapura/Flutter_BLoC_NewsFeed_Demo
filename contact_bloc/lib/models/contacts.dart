class Contact {
  int id;
  String name;
  String username;
  String email;

  Contact(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email']);
  }
}
