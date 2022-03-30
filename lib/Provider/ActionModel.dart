

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ActionModel extends ChangeNotifier{


  bool showSearch=false;


  List Countries=[];
  List filterlist=[];


  setList(List Countrie)
  {
    Countries=Countrie;
  }

  serachData(String searchkey)
  {
    print(searchkey);

    try{
      filterlist.clear();
      var obj= Countries.where((element) => searchkey.toLowerCase().contains(element['Country'].toLowerCase()));

      filterlist.add(obj.first);

      notifyListeners();
    }
    catch(e){};

    // Countries.map((e) {
    //
    //   print("kjkjkj");
    //
    //   if(searchkey==e['Country'])
    //   {
    //     filterlist.add(e);
    //   }
    // });
  }


  switchSearch()
  {
    showSearch=!showSearch;
    notifyListeners();

  }




}