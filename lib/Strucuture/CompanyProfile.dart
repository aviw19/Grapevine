class CompanyProfile
{
  int phoneno;
  String companyname;
  String aboutcompany;
  String email;
  String dob;
  String name;

  CompanyProfile(this.phoneno, this.companyname, this.aboutcompany,this.email,this.dob,this.name);

  Map<String, dynamic> toJson() => {
    "email":email,
    "phonno": phoneno,
    "companyname": companyname,
    "aboutcompany":aboutcompany,
    "dateofbirth":dob,
    "name":name

  };
}