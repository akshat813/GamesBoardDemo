import 'dart:convert';
import 'package:demo/Models/tournaments.dart';
import 'package:demo/constants/images.dart';
import 'package:demo/services/http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController scrollController = ScrollController();
  late ScrollController scrollController2 = ScrollController() ;
  String cursor = "";
  List<TournamentModel> tournaments = [];
  bool loader = true;
  bool loader2 = false;

  String username = "";
  String fullname = "";
  String rating = "";
  String profilePic = "";
  String played = "";
  String wonCount = "";
  String winPercentage = "";

  @override
  void initState() {
    getProfileData();
    getTournaments();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // ... call method to load more repositories
        print("at end of scroll");
        loader2 = true;
        setState(() {
        });
        Future.delayed(Duration(seconds: 2));
        getTournaments();
      }
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    scrollController.dispose();
    scrollController2.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        //padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                        onTap: (){
                        },
                        child: Image.asset(line_menu,height: 40,width: 40,))),
                    Text(username!="" || username!=null ? username : "",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Container(width: 10,)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  const CircleAvatar(backgroundImage: AssetImage(male_profile,),minRadius: 50,),
                  const SizedBox(width: 20,),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fullname==""|| fullname==null? "" : "Simon Baker" ,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color: Colors.blue)),
                        child:  Row(
                          children:  [
                            Text(rating=="" || rating==null ?"" : "2250  ",style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                            const Text("Elo rating",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25,),
              trophyBar(context),
              const SizedBox(height: 25,),
              const Text("  Recommended for you",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              loader == true ?
              Center(child: Container(
                margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator()))
              :
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.88,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController2,
                    itemBuilder: (context,index){
                    return Column(
                      children: [
                        tournamentCard(context,index),
                        const SizedBox(height: 18,)
                      ],
                    );
                  },
                    itemCount: tournaments==null? 0 : tournaments.length,
                    shrinkWrap: true,),
                ),
              ),
              loader2==true?
              Center(child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator()),
                  const SizedBox(height: 20,)
                ],
              ))
                  :
                 const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget trophyBar(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(14),
          width: MediaQuery.of(context).size.width*0.3,
          child: Text(played==""||played==null? "" :"$played\nTournaments Played",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          decoration: const BoxDecoration(borderRadius:
          BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                Color(0xffe68600),Color(0xffeba300)
              ]),
        )),
        Container(
            padding: EdgeInsets.all(14),
            width: MediaQuery.of(context).size.width*0.3,
            child: Text(wonCount==""||wonCount==null ?"" : "$wonCount\nTournaments won",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff542c9d),Color(0xff954db7),
              ],),
            )),
        Container(
            padding: EdgeInsets.all(14),
            width: MediaQuery.of(context).size.width*0.3,
            child: Text(winPercentage==null ||winPercentage==""? "": "$winPercentage\nWinning percentage",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                Color(0xffed5f47),Color(0xffef7a4e),
              ],),
            )),
      ],
    );
  }

  Widget tournamentCard(BuildContext context, int index)
  {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){},
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          elevation: 4,
          child: Container(
            height: MediaQuery.of(context).size.height*0.21,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height*0.14,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tournaments[index].detail.length>35 ? "${tournaments[index].detail.substring(0,35)}..." : "${tournaments[index].detail}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        Text("${tournaments[index].name}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey.shade600)),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    bottom: 60,
                    child: ClipRect(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.88,
                        height: MediaQuery.of(context).size.height*0.18,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken,),
                              fit: BoxFit.fill,
                              scale: 1,
                              image:  NetworkImage(
                                  tournaments[index].image),
                              alignment: FractionalOffset.topCenter,
                            )
                        ),
                      ),
                    )
                ),
                Positioned(
                    bottom: 20,
                    right: 10,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: (){},
                          child: Icon(Icons.arrow_forward_ios,size: 22,color: Colors.grey.shade600,)),
                    )
                ),
              ],
            ) ,
          ),
        ),
      ),
    );
  }

  Future<void> getTournaments() async
  {
    String url= "";
    if(cursor.isEmpty)
      {
        url = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all";
      }
    else
      {
        url = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor="+cursor;
      }
    var response = await RequestApi.getHttpRequest(url);
    loader = false;
    loader2 = false;
    setState(() {
    });
    var responseJson = await jsonDecode(response);
    print("responseJson${responseJson["data"]}");
    var responseData = responseJson["data"];
    cursor = responseData["cursor"]??"";
    setState(() {
    });
    for (var game in responseData["tournaments"])
      {
        tournaments.add(
            TournamentModel(
                detail: game["name"],
                image: game["cover_url"],
                name: game["game_name"]));

      };

  }

  Future<void> getProfileData() async
  {
    String url ="https://akshat813.github.io/demo_api/getprofileData.json";
    var response = await RequestApi.getHttpRequest(url);
    var responseJson = await jsonDecode(response);
    username = responseJson["userName"]??"";
    fullname = responseJson["name"]??"";
    rating = responseJson["rating"]??"";
    profilePic = responseJson["profilePic"]??"";
    played = responseJson["playedCount"]??"";
    wonCount = responseJson["wonCount"]??"";
    winPercentage = responseJson["winPercentage"]??"";
    setState(() {
    });
  }
}
