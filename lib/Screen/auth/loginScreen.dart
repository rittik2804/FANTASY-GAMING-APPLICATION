
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_number_game/common/commonTost.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/authCont/loginCont.dart';



class LoginScreen extends StatefulWidget {
 // const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());

  TextEditingController _Email=TextEditingController();
  TextEditingController _password=TextEditingController();
  bool visibile=true;

    
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: deepBacgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            
            height: height,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   width: double.infinity,
                  //  // color:Colors.blue,
                  //   child: Image(image: AssetImage("assets/logo3.png",),)),
                    SizedBox(height: 25,),
                    
                  FittedBox(child: Text("Login",style: TextStyle(fontSize: 38,color: primaryColor,fontWeight: FontWeight.w700)),),
                  SizedBox(height: 5,),
                  FittedBox(child: Text("Please login to your account",style: TextStyle(color: primaryColor,fontSize: 17),),),
                  SizedBox(height: 35,),
                  Container(
                  color: lightBackgroundCollor,
                  child: TextFormField(
                    
                      controller: _Email,
                      cursorColor: btnColor,
                      style:appbarTextStyle,
                      validator: (mailvalid) {
                        String pattern =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regExp = RegExp(pattern);
                        if (mailvalid!.isEmpty) {
                          return "Please enter your valid email address";
                        } else if (!(regExp.hasMatch(mailvalid))) {
                          return "Email must be end from @gmail.com";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:InputDecoration(
                          hintText: 'Email',
                          hintStyle: appbarTextStyle,
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                         focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                          borderRadius: BorderRadius.circular(5)
                        ),
                   
                    contentPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 18)
                    
                          
                         
                      )
                  ),
                ),
              SizedBox(height: 20,),
             Container(
             color: lightBackgroundCollor,
              // height:67,
              child: TextFormField(
                
                  controller: _password,

                  style:appbarTextStyle,
                  validator: (value) {
                    String pattern =
                        r'(?=.*?[#?!@$%^&*-])';
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return "Please enter your valid password";
                    } else if (!(regExp.hasMatch(value))) {
                      return "passwords must have at least one special character";
                    } else {
                      return null;
                    }},
                  obscureText: visibile,
                  decoration:InputDecoration(
                      suffixIcon: InkWell(
                          onTap: (){
                            setState((){
                              visibile=!visibile;
                            });
                          },
                      child: Icon(visibile==false?Icons.visibility_outlined:Icons.visibility_off_outlined,size: 18,color: primaryColor,)),
                      hintText: 'Password',
                      hintStyle: appbarTextStyle,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(5)
                    ),
                   
                    contentPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 18)
                    
                  ),
                 
                  cursorColor: borderColor,
                  
              ),
            ),

            SizedBox(height: 40,),
        
            Container(
              height: 60,
              width: double.infinity,
             child: ElevatedButton(
              onPressed: (){
              if (_Email.text.isNotEmpty&&_password.text.isNotEmpty) {
               
                _authController.signInWithEmailAndPassword(_Email.text, _password.text, context);
              
              }else{

               CommonToast(context: context, title: "Enter email and password", alignCenter: false);
             
              }
           

              },

               style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
               ),

              child: Obx(() =>
              _authController.isLoading.value==true?CircularProgressIndicator(color: primaryColor,):Text("Login",style: btnTextStyle,),),
               
               
               ),
            ),
                 
                    
                ],
              ),
            ),
          )
          ),
      ),
    );
  }
}