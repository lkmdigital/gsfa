class Student {
  int id;
  String matricule;
  String nom;
  String prenom;
  String date_naissance;
  String lieu_naissance;
  String classe;
  String telephone;

  Student(
    this.id,
    this.matricule,
    this.nom,
    this.prenom,
    this.classe,
    this.date_naissance,
    this.lieu_naissance,
    this.telephone,
  );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        int.parse(json["id"]),
        json["matricule"],
        json["nom"],
        json["prenom"],
        json["classe"],
        json["date_naissance"],
        json["lieu_naissance"],
        json["telephone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "matricule": matricule,
        "nom": nom,
        "prenom": prenom,
        "classe": classe,
        "date_naissance": date_naissance,
        "lieu_naissance": lieu_naissance,
        "code_famille": telephone,
      };
}
