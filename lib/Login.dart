import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapevineapp/Profile.dart';
import 'package:grapevineapp/SignUp.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
String _email;
String _password;
String ErrorText;
String authError;
bool errorTextPresentEmail = false;
bool errorTextPresentPassword=false;
String errorTextEmail;
String errorTextPassword;
final em=TextEditingController();
final pwd= TextEditingController();
class _LoginState extends State<Login> {

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
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  color: Color(0xFF0E0128),
                  borderRadius: BorderRadius.only(bottomRight:  Radius.circular(30),bottomLeft:  Radius.circular(30)),
                  boxShadow: [new BoxShadow(
                    blurRadius: 5,
                  ),]


              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("WELCOME TO ",style: TextStyle(color: Color(0xFFF3F2F6),fontWeight: FontWeight.w600,fontSize: 24)),
                  Text("GRAPEVINE",style: TextStyle(color: Color(0xFFF3F2F6),fontWeight: FontWeight.w600,fontSize: 36)),

                ],
              ),
            ),
            Container(
              child:Align(
                alignment: Alignment.topLeft,
                child:Text("Login",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),)),
              margin:EdgeInsets.fromLTRB(40, 40, 0, 0)),
              Container(
                  width: MediaQuery.of(context).size.width,
                  //height:MediaQuery.of(context).size.width*0.13 ,
                  margin:EdgeInsets.fromLTRB(40, 30, 0, 20),
                  padding: EdgeInsets.only(right: 40),
                  child: TextFormField(
                    onSaved: (value) => _email = value.trim(),
                    controller: em,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'Email',
                      errorText: errorTextPresentEmail ? errorTextEmail : null,
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
              //height:MediaQuery.of(context).size.width*0.13 ,
              margin:EdgeInsets.fromLTRB(40, 0, 0, 40),
              padding: EdgeInsets.only(right: 40),
              child: TextFormField(
                controller: pwd,
                onSaved: (value) => _password = value.trim(),
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 18),
                  hintText: 'Password',
                  errorText: errorTextPresentPassword?errorTextPassword:null,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.3,

                  decoration: BoxDecoration(
                    color: Color(0xFF0E0128),
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child:FlatButton(
                    child: Text('Login',style: TextStyle(
                      color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                    onPressed: () async {
                      FirebaseAuth auth=FirebaseAuth.instance;
                    _email= em.text.trim();
                    _password=pwd.text.trim();

                    FirebaseUser fbuser;
                    AuthResult result;
                    setState(() {
                      authError=null;
                      errorTextPresentEmail=false;
                      errorTextPresentPassword=false;
                      errorTextEmail=null;
                      errorTextPassword=null;
                    });
                    if(_email=="")
                    {
                      authError="Please enter email";
                      setState(() {
                        errorTextPresentEmail=true;
                        errorTextEmail=authError;
                      });
                    }
                    else if(_password=="")
                    {
                      authError="Please enter password";
                      setState(() {
                        errorTextPresentPassword=true;
                        errorTextPassword=authError;
                      });
                    }
                    else {
                      authError=null;
                      await pr.show();
                      try {
                        result = await auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                      }
                      on PlatformException catch (e) {
                        switch (e.code) {
                          case 'ERROR_USER_NOT_FOUND':
                            authError =
                            "User does not exist, Create one?";
                            errorTextPresentEmail=true;
                            break;
                          case 'ERROR_INVALID_EMAIL':
                            authError = 'Invalid Email';
                            errorTextPresentEmail=true;
                            break;
                          case 'ERROR_WRONG_PASSWORD':
                            authError = 'Incorrect Password';
                            errorTextPresentPassword=true;
                            break;
                          default :
                            authError = e.code.toString();

                            print(e.code);
                        }
                      }
                      if (authError != null) {

                        setState(() {
                          if(errorTextPresentEmail)
                            errorTextEmail=authError;
                          if(errorTextPresentPassword)
                            errorTextPassword=authError;
                        });
                        await pr.hide();
                      }
                      else {
                        SharedPreferences sp = await SharedPreferences
                            .getInstance();


                        fbuser = result.user;
                        sp.setString("firebaseid", fbuser.uid.toString());
                        sp.setString("loginType", "emailpassword");
                        sp.setBool("signedIn", true);
                        await pr.hide();
                        Navigator.pushAndRemoveUntil(
                            context,
                            //name MemeaTOken
                            MaterialPageRoute(builder: (context) =>
                                Profile()),
                            ModalRoute.withName('/Login')
                        );
                      }
                    }

                    },

              ))
            ],),
            Center(
              
              child:Container(
                margin: EdgeInsets.all(20),
              child: Text('or Connect Using',style: TextStyle(fontSize: 16,color: Color(0xFF706FA5)),),

            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width*0.3,

                    decoration: BoxDecoration(
                      color: Color(0xFF0E0128),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child:FlatButton(
                      child: Text('G Google',style: TextStyle(
                          color: Color(0xFFF3F2F6),fontSize: 20,fontWeight: FontWeight.bold
                      ),),

                    ))
              ],),
            Center(

                child:Container(
                  margin: EdgeInsets.all(20),
                  child: Text('By continuing, you agree to Grapevines' +'\n' +
                      '      Terms of Service, Privacy Policy' ,style: TextStyle(fontSize: 16,color: Color(0xFF706FA5)),),

                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text('New to Grapevine ?' ,style: TextStyle(fontSize: 16,color: Color(0xFF706FA5)),),
                ),
                Container(
                    child:FlatButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            //name MemeaTOken
                            MaterialPageRoute(builder: (context) =>
                               SignUp()),
                            ModalRoute.withName('/Login')
                        );
                      },
                      child: Text('Sign Up',style: TextStyle(
                          color: Color(0xFF706FA5),fontSize: 20,fontWeight: FontWeight.bold
                      ),),

                    ))
              ],)

          ],
        ),
      ))),
    );
  }
}
