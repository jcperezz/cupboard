import 'package:cupboard/models/cupboard.dart';
import 'package:cupboard/providers/rest_api_provider.dart';
import 'package:flutter/material.dart';

class CupboardsService extends ChangeNotifier {
  bool isLoading = false;
  Map<String, Cupboard> cupboards = Map();
  Cupboard? selected;

  CupboardsService() {
    _getAll();
  }

  Future _getAll() async {
    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> response =
          await RestApiProvider().get("/cupboards.json");

      cupboards = response.map((key, value) =>
          new MapEntry(key, new Cupboard.fromMap(value, id: key)));

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return Map();
    }
  }

  Future add(Cupboard entity) async {
    isLoading = true;
    notifyListeners();

    print("start add");

    try {
      Map<String, dynamic> data = entity.toMap();

      print("data $data");

      final response = await RestApiProvider().post("/cupboards.json", data);

      print(response);

      isLoading = false;
      _getAll();
      notifyListeners();
    } catch (e) {
      print(e);
      return Map();
    }
  }

  Future findById(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> response =
          await RestApiProvider().get("/cupboards/$id.json");

      selected = new Cupboard.fromMap(response, id: id);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return Map();
    }
  }
}
