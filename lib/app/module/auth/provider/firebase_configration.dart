import 'dart:async';
import 'package:alalamia_spices/app/data/providers/translations.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/auth/forgot_password/forgot_password_screen.dart';
import 'package:alalamia_spices/app/module/auth/sign_up/sign_up_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

int? forceResend;

class FirebasePhoneAuth {
  static var _authCredential, actualCode, phone, status;
  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
  StreamController.broadcast();
  static Stream stateStream = phoneAuthState.stream;

  static instantiate({required String phoneNumber}) async {
    assert(phoneNumber != null);
    phone = phoneNumber;
    startAuth();
  }

  static dispose() {
    statusStream.close();
    phoneAuthState.close();
  }





  static startAuth() async {
    WidgetsFlutterBinding.ensureInitialized();
    statusStream.stream.listen((String status) => debugPrint("PhoneAuth: " + status));
    addStatus('Phone auth started');

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone.toString(),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    ).then((value) {
      addStatus('Code sent');
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Error during phone verification: $error');
    });

  }



  static  PhoneCodeSent codeSent =
      (String verificationId, [int? forceResendingToken]) async {
    actualCode = verificationId;
    if (kDebugMode) {
      print("veeeer $verificationId");
    }
    //addStatus("\nEnter the code sent to " + phone);
    forceResend = forceResendingToken;
    addState(PhoneAuthState.CodeSent);
  };

  static  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
    addState(PhoneAuthState.AutoRetrievalTimeOut);
  };

  static  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException authException) {
    addStatus('Verification failed: ${authException.message}');
    addState(PhoneAuthState.Error);
  };


  static  PhoneVerificationCompleted verificationCompleted =
      (AuthCredential auth) {
    addStatus('Auto retrieving verification code');
    FirebaseAuth.instance.signInWithCredential(auth).then((confirmationResult) {

      if (kDebugMode) {
        print(confirmationResult);
      }
      if (confirmationResult != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
      } else {
        addState(PhoneAuthState.Failed);
        addStatus('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
    });
  };

  static signInWithPhoneNumber(
      {required String phoneNumber,
        required String smsCode,
        required BuildContext context,
        required bool isSignIn,
        required bool isRestPassword}) async {
    _authCredential = PhoneAuthProvider.credential(verificationId: actualCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(_authCredential)
        .then((confirmationResult) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful(
          context, phoneNumber, isSignIn, isRestPassword);
    }).catchError((error) {
      addState(PhoneAuthState.Failed);
      addStatus('Authentication failed: $error');
      onAuthenticationError(context , error.toString());
    });
  }

  static onAuthenticationSuccessful(
      BuildContext context, String phone, bool isSignIn, bool isRestPassword) {
    if (isSignIn) {
      if (isRestPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(phoneNumber: phone),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpTab(phoneNumber: phone),
          ),
        );
      }
    }

  }

  static onAuthenticationError(BuildContext context , String error) {
    // CustomToast.showFlutterToast(context: context, message: error , toastLength: Toast.LENGTH_LONG);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.vertical,
        duration: const Duration(seconds: 3),
        content: Text(
          allTranslations.text("wrongAuthCodeError"),
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontFamily: 'cairo'
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static addState(PhoneAuthState state) {
    if (kDebugMode) {
      print(state);
    }
    phoneAuthState.sink.add(state);
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
    if (kDebugMode) {
      print(s);
    }
  }
}
