import 'dart:convert';

import 'package:covid19api/Models.dart';
import 'package:covid19api/Provider/ActionModel.dart';
import 'package:covid19api/Services.dart';
import 'package:covid19api/constraints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

      ChangeNotifierProvider(
        create: (context) => ActionModel(),)
    ],

      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHome(),
      ),
    );
  }
}


class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {



  Models? modelsl;
  final PageController controller = PageController();


  bool showTextField=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){

                Provider.of<ActionModel>(context, listen: false).switchSearch();

              },

              icon: Icon(Icons.search),


            ),
          ),

        ],
        // title: ,

        title: Consumer<ActionModel>(builder: (context, value, child) => value.showSearch==false?Text("Covid19 Application"):
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),

            ),
            onChanged: (e)
            {
              Provider.of<ActionModel>(context, listen: false).serachData(e.toString());
            },
          ),
        ),),
        centerTitle: true,
      ),


      body: FutureBuilder(
        future: Services.getSummaryResponse(),
        builder: (context , AsyncSnapshot<dynamic> snapshot){


          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return Text("There is Some error");
          }
          if(snapshot.hasData){


            List Countries = jsonDecode(snapshot.data)['Countries'];
           ActionModel model= Provider.of<ActionModel>(context);


            Provider.of<ActionModel>(context).setList(Countries);

            var a = jsonDecode(snapshot.data)['Global'];

            print(jsonDecode(snapshot.data)['Global']['Date']);
            print(Countries.length.toString());


            return Column(

              children: <Widget>[



                Container(
                  height: 200,
                  color: Colors.white,
                  child: PageView(
                    /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                    /// Use [Axis.vertical] to scroll vertically.
                    controller: controller,
                    children:  <Widget>[

                        Padding(
                  padding: EdgeInsets.only(left: 15.0 , right: 15.0 , top: 10.0 , bottom: 10.0),
                    child: Container(
                    decoration: BoxDecoration(
                    color: Color(0xb26d89f3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),

                  child: Row(
                    children: <Widget>[


                      Image(
                        height: 150,
                        width: 150,
                        image: AssetImage("images/a.png"),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text("Worldwide Cases" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 16),),

                          SizedBox(height: 7.0),
                          Text("${a['Date']}"),
                          SizedBox(height: 12.0),


                          Text("${a['TotalConfirmed']}" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 20)),



                        ],
                      )


                    ],
                  )

              ),
            ),


                      Padding(
                        padding: EdgeInsets.only(left: 15.0 , right: 15.0 , top: 10.0 , bottom: 10.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xb26d89f3),
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("New Confirmed" , style: KNewConfirmStylekey),


                                    Text("${a['NewConfirmed']}" , style: KNewConfirmStylevalue),

                                    Text("Total Confirmed",style: KNewConfirmStylekey),


                                    Text("${a['TotalConfirmed']}",style: KNewConfirmStylevalue),



                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[


                                    Text("New Deaths" , style: KNewConfirmStylekey),


                                    Text("${a['NewDeaths']}" , style: KNewConfirmStylevalue),

                                    Text("Total Deaths",style: KNewConfirmStylekey),


                                    Text("${a['TotalDeaths']}",style: KNewConfirmStylevalue),



                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                    Text("New Recovered" , style: KNewConfirmStylekey),


                                    Text("${a['NewRecovered']}" , style: KNewConfirmStylevalue),

                                    Text("Total Recovered",style: KNewConfirmStylekey),


                                    Text("${a['TotalRecovered']}",style: KNewConfirmStylevalue),



                                  ],
                                ),


                              ],
                            )

                        ),
                      ),


                    ],
                  )
                ),
                Expanded(
                  child: Consumer<ActionModel>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        itemCount:model.showSearch? model.filterlist.length : model.Countries.length,
                        itemBuilder: (context, index) {
                          
                          List data=model.showSearch? value.filterlist:value.Countries;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue,
                                      offset: Offset(0.5,1),
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.outer
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage("https://countryflagsapi.com/png/"+"${data[index]['CountryCode']}"),),

                                        SizedBox(
                                          height: 10.0,
                                        ),

                                        Container(
                                          width: 80,
                                          child: Center(
                                            child: Text("${data[index]['Country']}" , style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Color(0xee24253d)

                                            ),),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text("${data[index]['CountryCode']}"),

                                      ],
                                    ),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blue,
                                                  offset: Offset(0.5,1),
                                                  blurRadius: 2,
                                                  blurStyle: BlurStyle.outer
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          child: Icon(Icons.emoji_people)),


                                      Text("New Confirmed" , style: KNewConfirmStylekey),


                                      Text("${data[index]['NewConfirmed']}" , style: KNewConfirmStylevalue),

                                      Text("Total Confirmed",style: KNewConfirmStylekey),


                                      Text("${data[index]['TotalConfirmed']}",style: KNewConfirmStylevalue),



                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blue,
                                                  offset: Offset(0.5,1),
                                                  blurRadius: 2,
                                                  blurStyle: BlurStyle.outer
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          child: Icon(Icons.sick_outlined)),


                                      Text("New Deaths" , style: KNewConfirmStylekey),


                                      Text("${data[index]['NewDeaths']}" , style: KNewConfirmStylevalue),

                                      Text("Total Deaths",style: KNewConfirmStylekey),


                                      Text("${data[index]['TotalDeaths']}",style: KNewConfirmStylevalue),



                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blue,
                                                  offset: Offset(0.5,1),
                                                  blurRadius: 2,
                                                  blurStyle: BlurStyle.outer
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          child: Icon(Icons.record_voice_over)),


                                      Text("New Recovered" , style: KNewConfirmStylekey),


                                      Text("${data[index]['NewRecovered']}" , style: KNewConfirmStylevalue),

                                      Text("Total Recovered",style: KNewConfirmStylekey),


                                      Text("${data[index]['TotalRecovered']}",style: KNewConfirmStylevalue),



                                    ],
                                  ),




                                ],
                              ),
                            ),
                          );

                        },);
                    }
                  ),
                ),

              ],
            );

          }



          return Container();
        },
      )
      
    );
  }
}
