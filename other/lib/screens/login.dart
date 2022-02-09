import 'package:demo/constants/images.dart';
import 'package:demo/constants/strings.dart';
import 'package:demo/screens/homepage.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  bool usernameVerify = false;
  bool passwordVerify = false;
  var users = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    setPreference();
    // TODO: implement initState
    //  super.initState();
  }

  void setPreference() async
  {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(logo,
                        fit: BoxFit.fill,
                        height: 90,
                        width: MediaQuery.of(context).size.width*0.5,),
                    )),
              ),
              SizedBox(height: 50,),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextField(
                    onChanged: (String value){
                      //print("onchange username");
                      if(value.length>=3 && value.length<=11)
                        {
                          usernameVerify = true;
                          setState(() {
                          });
                        }
                    },
                    onSubmitted: (value){
                      if(value.length>=3 && value.length<=11)
                        {
                          usernameVerify = true;
                          print("usernameverified");
                          setState(() {
                          });
                        }
                      else
                        {
                          Fluttertoast.showToast(msg: "Min 3 and max 11 characters allowed");
                        }
                    },
                    controller: usernameCont,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Username",
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextField(
                    onChanged: (String value)
                    {
                      //print("onchange password");
                      if(value.length>=3 && value.length<=11)
                      {
                        passwordVerify = true;
                        setState(() {
                        });
                      }
                    },
                    onSubmitted: (value){
                      print("passwordverified");
                      if(value.length>=3 && value.length<=11)
                      {
                        passwordVerify = true;
                        setState(() {
                        });
                      }
                      else
                      {
                        Fluttertoast.showToast(msg: "Min 3 and max 11 characters allowed");
                      }
                    },
                    controller: passCont,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Password",
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: MaterialButton(
                  color: usernameVerify==true && passwordVerify==true?  Colors.black : Colors.grey ,
                  onPressed: usernameVerify==true && passwordVerify==true ? ()
                  {
                    print("username $usernameVerify,password $passwordVerify");

                    if(usernameCont.text.trim() == "9898989898" && passCont.text.trim() == "password123")
                      {
                        prefs.setBool(userLoggedIn, true);
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage()));
                      }
                    if(usernameCont.text.trim() == "9876543210" && passCont.text.trim() == "password123")
                      {
                        prefs.setBool(userLoggedIn, true);
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage()));
                      }
                    else
                    {
                      Fluttertoast.showToast(msg: "Invalid user!");
                    }
                  }
                  :
                  (){
                    print("username $usernameVerify,password $passwordVerify");
                    Fluttertoast.showToast(msg: "Required fields empty!");
                  },
                  child: const Text("Submit",style: TextStyle(color: Colors.white),).tr(),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
