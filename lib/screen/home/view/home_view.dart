import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/home_model.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? homeProviderT;
  HomeProvider? homeProviderF;

  @override
  Widget build(BuildContext context) {
    homeProviderT = Provider.of<HomeProvider>(context, listen: true);
    homeProviderF = Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Covid"),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: homeProviderF!.getCoronaData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      CoronaModel? c1 = snapshot.data;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white,width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" => ${c1.worldTotal.totalCases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 5,),
                                  Text(" => ${c1!.statisticTakenAt}",style: GoogleFonts.lato(fontSize: 5),),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Country => ${c1.countriesStat[index].countryName}",style: GoogleFonts.lato(
                                    fontSize: 5,
                                  ),),
                                  SizedBox(height: 5,),

                                  Text(
                                      "Active =>${c1.countriesStat[index].activeCases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 5,),
                                  Text(
                                      "Total =>${c1.countriesStat[index].cases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Death => ${c1.countriesStat[index].deaths}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Recoverd:${c1.countriesStat[index].totalRecovered}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: c1!.countriesStat.length,
                      );
                    }
                    return Container(height: 50,width: 50,
                        child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ));
  }
}