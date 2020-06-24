import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapevineapp/ProfileEdit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;
final em=TextEditingController();
final pwd=TextEditingController();
final uname=TextEditingController();
final cnpwd=TextEditingController();
String _email;
String _password;
String _confirmpassword;
String _username;
String authError;
String errorTextEmail;
String errorTextPassword;
String errorTextUsername;
String errorTextConfirmPassword;
bool errorTextConfirmPasswordPresent=false;
bool errorTextEmailPresent=false;
bool errorTextPasswordPresent=false;
bool errorTextUsernamePresent=false;

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        body: SafeArea(
          child:SingleChildScrollView(
          child:Center(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width,


                decoration: BoxDecoration(
                    color: Color(0xFFABB1D6),
                    borderRadius: BorderRadius.only(bottomRight:  Radius.circular(30),bottomLeft:  Radius.circular(30)), boxShadow: [new BoxShadow(
                  blurRadius: 5,
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
                  child:Align(
                      alignment: Alignment.topLeft,
                      child:Text("Sign Up",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),)),
                  margin:EdgeInsets.fromLTRB(40, 40, 0, 0)),
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.width*0.13 ,
                margin:EdgeInsets.fromLTRB(40, 30, 0, 20),
                padding: EdgeInsets.only(right: 40),
                child: TextFormField(
                  controller: uname,
                  onSaved: (value) => _username = value.trim(),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Name',
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
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.width*0.13 ,
                margin:EdgeInsets.fromLTRB(40, 10, 0, 20),
                padding: EdgeInsets.only(right: 40),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: em,
                  onSaved: (value) => _email = value.trim(),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Email',
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
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.width*0.13 ,
                margin:EdgeInsets.fromLTRB(40, 10, 0, 20),
                padding: EdgeInsets.only(right: 40),
                child: TextFormField(
                  controller: pwd,
                  onSaved: (value) => _password = value.trim(),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Password',
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
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.width*0.13 ,
                margin:EdgeInsets.fromLTRB(40, 10, 0, 20),
                padding: EdgeInsets.only(right: 40),
                child: TextFormField(
                  controller: cnpwd,
                  onSaved: (value) => _confirmpassword = value.trim(),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Confirm Password',
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
                      child: Text('Sign Up',style: TextStyle(
                     color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                      )),
                    onPressed: () async {
                        await pr.show();

                        _email=em.text.trim();
                        _password=pwd.text.trim();
                        _username=uname.text.trim();
                        _confirmpassword=cnpwd.text.trim();
                        FirebaseAuth auth = FirebaseAuth.instance;
                        AuthResult result;
                        /*setState(() {
                        authError=null;
                        errorTextUsernamePresent=false;
                        errorTextEmailPresent=false;
                        errorTextPasswordPresent=false;
                        errorTextConfirmPasswordPresent=false;
                        });
                        if(_username=="")
                        {
                        setState(() {
                        errorTextUsernamePresent=true;
                        errorTextUsername="Please enter Name";
                        });
                        }
                        else if(_email=="")
                        {
                        setState(() {
                        errorTextEmailPresent=true;
                        errorTextEmail="Please enter Email";
                        });
                        }
                        else if(_password=="")
                        {
                        setState(() {
                        errorTextPasswordPresent=true;
                        errorTextPassword="Please enter Password";
                        });
                        }
                        else if(_confirmpassword=="")
                        {
                        setState(() {
                        errorTextConfirmPasswordPresent=true;
                        errorTextConfirmPassword="Please fill this field";
                        });
                        }
                        else if(!(_password.compareTo(_confirmpassword)==0))
                        {
                        setState(() {
                        errorTextConfirmPasswordPresent=true;
                        errorTextConfirmPassword="Passwords don't match";
                        });
                        }
                        else {*/
                          await pr.show();
                          authError = null;
                          try {
                            result = await auth.createUserWithEmailAndPassword(
                                email: _email, password: _password);
                          }
                          on PlatformException catch (e) {
                            print(e.code);
                            switch (e.code) {
                              case 'ERROR_EMAIL_ALREADY_IN_USE':
                                authError =
                                "An account already exists with this email";
                                errorTextEmailPresent = true;
                                break;
                              case 'ERROR_INVALID_EMAIL':
                                authError = "Please enter a valid email";
                                errorTextEmailPresent = true;
                                break;
                              case 'ERROR_WEAK_PASSWORD':
                                authError = "Please set a strong password";
                                errorTextPasswordPresent = true;
                                break;
                              default:
                                authError = e.code;
                            }
                          }

                          if (authError != null) {
                            await pr.hide();
                            if (errorTextEmailPresent)
                              setState(() {
                                errorTextEmailPresent = true;
                                errorTextEmail = authError;
                              });
                            if (errorTextPasswordPresent)
                              setState(() {
                                errorTextPasswordPresent = true;
                                errorTextPassword = authError;
                              });
                          }
                          else {
                            FirebaseUser fbuser = result.user;
                            _username = uname.text;
                            FirebaseDatabase firebasedatabase = FirebaseDatabase.instance;
                            DatabaseReference d=firebasedatabase.reference().child('Get Hired');
                            DatabaseReference d1= firebasedatabase.reference().child('Hire Someone');
                            d.child(fbuser.uid).child('Name').set(_username);
                            await pr.hide();
                            SharedPreferences sp = await SharedPreferences
                                .getInstance();
                            sp.setBool("signedIn", true);
                            sp.setString("firebaseid", fbuser.uid);
                            sp.setString("name",_username);
                            sp.setString("email", _email);
                            print(fbuser.uid);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ProfileEdit()),
                              ModalRoute.withName('/SignUp'),
                            );
                          }
                        }




                  )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text('By continuing, you agree to Grapevine\'s' +'\n' +
          '      Terms of Service, Privacy Policy' ,style: TextStyle(fontSize: 16,color: Color(0xFF706FA5)),),

              ),


            ],

          ),
        )),
    ));
  }

}
