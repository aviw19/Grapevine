import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grapevineapp/Chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
String _dateofbirth=" ";
String _phoneno=" ";
String _skills=" ";
String _desc=" ";
String _name=" ";
String _email=" ";
String firebaseid=" ";


class _ProfileState extends State<Profile> {
  Future<void> getInitialDetails() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    firebaseid=sp.getString("firebaseid");
    FirebaseDatabase firebaseDatabase = await FirebaseDatabase.instance;
    DatabaseReference databaseReference= firebaseDatabase.reference().child("Get Hired");
    DatabaseReference databaseReference1=firebaseDatabase.reference().child("Hire Someone");
    String dateofbirth=(await databaseReference.child(firebaseid).child("dateofbirth").once()).value.toString();
    String name=(await databaseReference.child(firebaseid).child("name").once()).value.toString();
    String desc=(await databaseReference.child(firebaseid).child("desc").once()).value.toString();
    String skills=(await databaseReference.child(firebaseid).child("dateofbirth").once()).value.toString();
    String email=(await databaseReference.child(firebaseid).child("email").once()).value.toString();
    String phoneno=(await databaseReference.child(firebaseid).child("phoneno").once()).value.toString();
    setState(()  {
      if(dateofbirth!=null)
     _dateofbirth=dateofbirth;
      if(_name!=null)
     _name=name;
      if(desc!=null)
        _desc=desc;
      if(skills!=null)
        _skills=skills;
      if(email!=null)
        _email=email;
      if(phoneno!=null)
        _phoneno=_phoneno;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    getInitialDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  child: Text(_dateofbirth,style: TextStyle(fontSize: 18,color: Color(0xFF0E0128),fontWeight: FontWeight.w300),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height*0.45,

                  margin: EdgeInsets.fromLTRB(20,10,20,20),
                  child: _tabSection(context),
                  decoration: BoxDecoration(
                    color: Color(0xffABB1D6),
                    borderRadius: BorderRadius.all(Radius.circular(30),), boxShadow: [new BoxShadow(
                  ),]

                )),
                Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E0128),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child:FlatButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              Chat()),
                          ModalRoute.withName('/SignUp'),
                        );

                      },
                      child: Text('Chat',style: TextStyle(
                          color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                      ),),

                    )),
              ],
            ),


          ),
      ),
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
              height: MediaQuery.of(context).size.height*0.38,
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
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 10, 20),
      height: MediaQuery.of(context).size.height,
        child:Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child:Text('Phone Number',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
          Align(
              alignment: Alignment.topLeft,
              child:Text(_phoneno,style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),
          SizedBox(
            height: 30,
          ),
          Align(
              alignment: Alignment.topLeft,
              child:Text('Skills',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
          Align(
              alignment: Alignment.topLeft,
              child:Text(_skills,style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),
          SizedBox(
            height: 30,
          ),
          Align(
              alignment: Alignment.topLeft,
              child:Text('About me',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
          Align(
              alignment: Alignment.topLeft,
              child:Text(_desc,style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),





      ]),
    );
  }
  Widget _HireSomeone(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 10, 20),
      height: MediaQuery.of(context).size.height,
      child:Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child:Text('Phone Number',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
            Align(
                alignment: Alignment.topLeft,
                child:Text('9713016336',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.topLeft,
                child:Text('Company',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
            Align(
                alignment: Alignment.topLeft,
                child:Text('Grapevine',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.topLeft,
                child:Text('About Company',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w500,fontSize: 18),)),
            Align(
                alignment: Alignment.topLeft,
                child:Text('Connecting people to find their dream jobs.',style: TextStyle(color: Color(0xFF0E0128),fontWeight: FontWeight.w300,fontSize: 18),)),





          ]),

    );
  }
}


