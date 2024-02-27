class VereinInput {
  final String panrede;
  final String pvorname;
  final String pname;
  final String pstrasse;
  final String pplz;
  final String port;
  final String pmobil;
  final String pemail;
  final String pgebdatum;
  final String pcfield1;
  final String pcfield2;
  final String pcfield3;
  final String pcfield4;
  final String pcfield5;
  final String pcfield6;

  VereinInput({
    required this.panrede,
    required this.pvorname,
    required this.pname,
    required this.pstrasse,
    required this.pplz,
    required this.port,
    required this.pmobil,
    required this.pemail,
    required this.pgebdatum,
    required this.pcfield1,
    required this.pcfield2,
    required this.pcfield3,
    required this.pcfield4,
    required this.pcfield5,
    required this.pcfield6,
  });

  // Methode zur Konvertierung des Objekts in ein Map, nützlich für HTTP-Anfragen
  Map<String, dynamic> toMap() {
    return {
      'panrede': panrede,
      'pvorname': pvorname,
      'pname': pname,
      'pstrasse': pstrasse,
      'pplz': pplz,
      'port': port,
      'pmobil': pmobil,
      'pemail': pemail,
      'pgebdatum': pgebdatum,
      'pcfield1': pcfield1,
      'pcfield2': pcfield2,
      'pcfield3': pcfield3,
      'pcfield4': pcfield4,
      'pcfield5': pcfield5,
      'pcfield6': pcfield6,
    };
  }

  // Optionale: Methode zur Erstellung eines Mitgliedsantrag-Objekts aus einem Map
  factory VereinInput.fromMap(Map<String, dynamic> map) {
    return VereinInput(
      panrede: map['panrede'],
      pvorname: map['pvorname'],
      pname: map['pname'],
      pstrasse: map['pstrasse'],
      pplz: map['pplz'],
      port: map['port'],
      pmobil: map['pmobil'],
      pemail: map['pemail'],
      pgebdatum: map['pgebdatum'],
      pcfield1: map['pcfield1'],
      pcfield2: map['pcfield2'],
      pcfield3: map['pcfield3'],
      pcfield4: map['pcfield4'],
      pcfield5: map['pcfield5'],
      pcfield6: map['pcfield6'],
    );
  }
}
