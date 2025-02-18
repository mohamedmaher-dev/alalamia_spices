import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Manage TextFormField Controller
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameHolderController = TextEditingController();



  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }



  @override
  void dispose() {
    cardNumberController.dispose();
    nameHolderController.dispose();
    cvvController.dispose();
    expDateController.dispose();
    super.dispose();
  }
  void disposeControllers() {
    cardNumberController.dispose();
    nameHolderController.dispose();
    cvvController.dispose();
    expDateController.dispose();
  }
}