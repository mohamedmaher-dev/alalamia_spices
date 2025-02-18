
import 'package:flutter/material.dart';

class CheckoutFormProvider with ChangeNotifier{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Manage TextFormField Controller
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nearestLandmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();



  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }



  @override
  void dispose() {
    recipientNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    nearestLandmarkController.dispose();
    cityController.dispose();
    super.dispose();
  }
  void disposeControllers() {
    recipientNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    nearestLandmarkController.dispose();
    cityController.dispose();
  }
}