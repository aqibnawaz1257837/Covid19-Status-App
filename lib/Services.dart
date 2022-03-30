import 'package:covid19api/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Services{


  static Future<dynamic> getSummaryResponse() async{



    try{

      var request = http.Request('GET', Uri.parse('https://api.covid19api.com/summary'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res =  await response.stream.bytesToString();
        // Models respone =modelsFromJson(res);


        print( "assda" +res.length.toString());

        return res;
      }
      else {
        print(response.reasonPhrase);
        return "0";
      }
    }
    catch(e){

      print(e.toString());


    }




  }

}