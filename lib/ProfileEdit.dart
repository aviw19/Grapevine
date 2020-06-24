import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grapevineapp/Profile.dart';
import 'package:grapevineapp/Strucuture/UserProfile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}
final dobcontroller=TextEditingController();
final phonenocontroller= TextEditingController();
final skillscontroller=TextEditingController();
final desccontroller=TextEditingController();
final aboutcompanycontroller=TextEditingController();
final namecompanycontroller=TextEditingController();
String _dateofbirth;
String _phoneno;
String _aboutcompany;
String _nameofcompany;
String _skills;
String _desc;
String _name=" ";
String _email=" ";

class _ProfileEditState extends State<ProfileEdit> {
  Future<void> getSharedPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _name=sp.getString("name");
    _email=sp.getString("email");



  }
@override
  void initState() {
    // TODO: implement initState
    getSharedPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                    color: Color(0xFFABB1D6),
                    borderRadius: BorderRadius.only(bottomRight:  Radius.circular(30),bottomLeft:  Radius.circular(30)), boxShadow: [new BoxShadow(
                  blurRadius: 10

                ),]


                ),
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Image.asset('assets/logo.png'),

                  ),
                  Container(
                      child:Text('GRAPEVINE',style: TextStyle(fontSize: 35,color: Color(0xff3C2C59),fontWeight: FontWeight.bold),)
                  ),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xffABB1D6),
                  child: Icon(Icons.person,color: Color(0xFF0E0128),size: 80,),
                ),
              ),
              Container(
                child: Text(_name,style: TextStyle(fontSize: 24,color: Color(0xFF000000),fontWeight: FontWeight.w500),),
              ),
              Container(
                child: Text(_email,style: TextStyle(fontSize: 18,color: Color(0xFF000000),fontWeight: FontWeight.w500),),
              ),
          Container(
            width: MediaQuery.of(context).size.width*0.6,
            height: MediaQuery.of(context).size.width*0.12,
          child:TextFormField(
            controller: dobcontroller,
              onSaved: (value) => _dateofbirth = value.trim(),
            decoration: InputDecoration(
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30),
                ),
              ),
              hintStyle: TextStyle(fontSize: 18,color: Color(0xff706FA5)),
              hintText: 'Date of Birth',
              enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30),
                ),
              )))),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height*0.5,

                  margin: EdgeInsets.fromLTRB(20,10,20,20),
                  child: _tabSection(context),
                  decoration: BoxDecoration(
                      color: Color(0xffABB1D6),
                      borderRadius: BorderRadius.all(Radius.circular(30),), boxShadow: [new BoxShadow(
                  ),]

                  )),

            ],
          ),


        ),
        )),
    );

  }
  Widget _tabSection(BuildContext context)
  {
    return DefaultTabController(
      length: 2,

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: TabBar(

                  unselectedLabelColor:Colors.white ,
                  labelColor:Colors.black,
                  indicatorColor: Color(0xff706FA5),


                  tabs: [
                    Tab(text: "Get Hired"),
                    Tab(text: "Hire Someone"),
                  ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.44,
              child: TabBarView(

                children: <Widget>[
                  _GetHired(context),_HireSomeone(context),


                ],
              ),

            ),
          ]),

    );
  }
  Widget _GetHired(BuildContext context)
  {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        backgroundColor: Theme.of(context).backgroundColor,
        message: "Please wait...",
        progressWidget: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        messageTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 19.0,
            fontWeight: FontWeight.w600));
    return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        height: MediaQuery.of(context).size.height,
      child: Center(

      child:Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: phonenocontroller,
                  onSaved: (value) => _phoneno = value.trim(),
                 decoration: InputDecoration(
                   focusedBorder:OutlineInputBorder(
                     borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                     ),
                     borderRadius: const BorderRadius.all(
                       const Radius.circular(30),
                     ),
                   ),
                    hintStyle: TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                    hintText: 'Phone Number',
                     enabledBorder:OutlineInputBorder(
                     borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                        ),
                borderRadius: const BorderRadius.all(
                const Radius.circular(30),
              ),
            ),
              border: new OutlineInputBorder(
                borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                borderRadius: const BorderRadius.all(
              const Radius.circular(30),
              ),


      ),
    ),

    ),
    ),
            SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                controller: skillscontroller,
                onSaved: (value) => _skills = value.trim(),
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  hintStyle: TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                  hintText: 'Skills',
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),


                  ),
                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                controller: desccontroller,
                onSaved: (value) => _desc = value.trim(),
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  hintStyle:  TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                  hintText: 'Describe yourself in 3 sentences',
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),


                  ),
                ),

              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.3,
                margin: EdgeInsets.only(top: 20),


                decoration: BoxDecoration(
                  color: Color(0xFF0E0128),
                  borderRadius: BorderRadius.circular(30),

                ),
                child:FlatButton(
                  onPressed: () async
                    {
                      await pr.show();
                      FirebaseDatabase firebaseDatabase =  FirebaseDatabase.instance;
                      DatabaseReference databaseReference = firebaseDatabase.reference();
                      final hiretype = databaseReference.child('Get Hired');
                      FirebaseAuth auth=FirebaseAuth.instance;
                      SharedPreferences sp = await SharedPreferences.getInstance();
                      _phoneno=phonenocontroller.text.trim();
                      _skills=skillscontroller.text.trim();
                      _desc=desccontroller.text.trim();
                      _dateofbirth=dobcontroller.text.trim();
                      var uid= sp.get('firebaseid');
                      var e = hiretype.child(uid);
                      _name=sp.getString("name");
                      _email=sp.getString("email");
                      e.set(UserProfile(int.parse(_phoneno),_skills,_desc,_email,_dateofbirth,_name).toJson());
                      pr.hide();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Profile()),
                        ModalRoute.withName('/Profile'),
                      );

                  },
                  child: Text('Save',style: TextStyle(
                      color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                  ),),

                )),




          ]),
      ));
  }
  Widget _HireSomeone(BuildContext context)
  {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        backgroundColor: Theme.of(context).backgroundColor,
        message: "Please wait...",
        progressWidget: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        messageTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 19.0,
            fontWeight: FontWeight.w600));
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: MediaQuery.of(context).size.height,
      child:Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  hintStyle: TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                  hintText: 'Phone Number',
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),


                  ),
                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  hintStyle: TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                  hintText: 'Company Name',
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),


                  ),
                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  hintStyle:  TextStyle(fontSize: 18,color: Color(0xffF3F2F6)),
                  hintText: 'About Company',
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Color(0xFF706FA5)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),


                  ),
                ),

              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.3,
                margin: EdgeInsets.only(top: 20),


                decoration: BoxDecoration(
                  color: Color(0xFF0E0128),
                  borderRadius: BorderRadius.circular(30),

                ),
                child:FlatButton(
                  onPressed: () async {
                      await pr.show();
                      FirebaseDatabase firebaseDatabase =  FirebaseDatabase.instance;
                      DatabaseReference databaseReference = firebaseDatabase.reference();
                      final hiretype = databaseReference.child('Get Hired');
                      FirebaseAuth auth=FirebaseAuth.instance;
                      SharedPreferences sp = await SharedPreferences.getInstance();
                      _phoneno=phonenocontroller.text.trim();
                      _skills=skillscontroller.text.trim();
                      _desc=desccontroller.text.trim();
                      _dateofbirth=dobcontroller.text.trim();
                      var uid= sp.get('firebaseid');
                      var e = hiretype.child(uid);
                      _name=sp.getString("name");
                      _email=sp.getString("email");
                      e.set(UserProfile(int.parse(_phoneno),_skills,_desc,_email,_dateofbirth,_name).toJson());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Profile()),
                        ModalRoute.withName('/Profile'),
                      );
                  },
                  child: Text('Save',style: TextStyle(
                      color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                  ),),

                )),




          ]),
    );

  }




}
