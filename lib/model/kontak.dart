class Kontak {
  int? id;
  String? name;
  String? mobileNo;
  String? email;
  String? company;
  DateTime? birthDate; // Tambahkan field tanggal lahir

  Kontak(
      {this.id,
      this.name,
      this.mobileNo,
      this.email,
      this.company,
      this.birthDate});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['mobileNo'] = mobileNo;
    map['email'] = email;
    map['company'] = company;
    map['birthDate'] = birthDate
        ?.millisecondsSinceEpoch; // Simpan tanggal lahir dalam format milisekon dari epoch

    return map;
  }

  Kontak.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.mobileNo = map['mobileNo'];
    this.email = map['email'];
    this.company = map['company'];
    this.birthDate = map['birthDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'])
        : null; // Ubah kembali ke DateTime
  }
}
