import 'package:flutter/widgets.dart';

import '../../../utils/home_helper.dart';
import '../model/home_model.dart';

class HomeProvider extends ChangeNotifier {
  Future<CoronaModel> getCoronaData() async {
    Apihelper apihelper = Apihelper();
    CoronaModel coronaModel = await apihelper.getCoronaApi();
    return coronaModel;
  }
}