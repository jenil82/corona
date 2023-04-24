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
  HomeProvider? homeProviderTrue;
  HomeProvider? homeProviderFalse;

  @override
  Widget build(BuildContext context) {
    homeProviderTrue = Provider.of<HomeProvider>(context, listen: true);
    homeProviderFalse = Provider.of<HomeProvider>(context, listen: false);
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
                  future: homeProviderFalse!.getCoronaData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      CoronaModel? deta = snapshot.data;
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
                                  Text(" => ${deta?.worldTotal.totalCases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 5,),
                                  Text(" => ${deta!.statisticTakenAt}",style: GoogleFonts.lato(fontSize: 5),),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Country => ${deta.countriesStat[index].countryName}",style: GoogleFonts.lato(
                                    fontSize: 5,
                                  ),),
                                  SizedBox(height: 5,),

                                  Text(
                                      "Active =>${deta.countriesStat[index].activeCases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 5,),
                                  Text(
                                      "Total =>${deta.countriesStat[index].cases}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Death => ${deta.countriesStat[index].deaths}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Recoverd:${deta.countriesStat[index].totalRecovered}",style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: deta!.countriesStat.length,
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