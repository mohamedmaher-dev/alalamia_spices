

import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class HomeNote extends StatelessWidget {
  const HomeNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<NoteModel>(context , listen:  false);
    return model.isLoading || model.loadingFailed
        ? const CircularLoading()
        : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5.w),
      color: Theme.of(context).colorScheme.secondary,
      child: Text(
        model.note.message.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: "cairo"
        ),
      ),
    );
  }
}
