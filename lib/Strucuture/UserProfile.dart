
class UserProfile
{
  int phoneno;
  String skills;
  String desc;
  String email;
  String dob;
  String name;

  UserProfile(this.phoneno, this.skills, this.desc,this.email,this.dob,this.name);

  Map<String, dynamic> toJson() => {
    "email":email,
    "phonno": phoneno,
    "skills": skills,
    "desc":desc,
    "dateofbirth":dob,
    "name":name

  };
}