import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:templesapp/cardholder.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  //
  final List<List<String>> events = [
    ["lib/pics/dussera.jpg", "Dussera 2023 Dates"],
    ["lib/pics/Bathukamma.jpg", "Bonalu 2023 Dates"],
    ["lib/pics/ramzan.jpg", "Ramzan 2023 Dates"],
    ["lib/pics/sammakka.jpg", "Sammaka Sarakka Jathara Dates"]
  ];
  final List<String> images = [
    "lib/pics/chilkurbalaji.jpg",
    "lib/pics/gnanasaraswati.jpg",
    "lib/pics/karmanghat.jpg",
    "lib/pics/sanghitemple.jpg",
    "lib/pics/surendrapuri.jpg",
    "lib/pics/birlamandir.jpg",
  ];

  final List<List<String>> st = [
    ["lib/pics/sri krishna.jpg", "Sri Krishna \n Stotram"],
    ["lib/pics/saraswati devi.jpg", "Saraswati \n Stotram"],
    ["lib/pics/hanumanchalisa.jpg", "Hanuman Chalisa \n Stotram"],
    ["lib/pics/sri ram.jpg", "Rama Raksha\nStotram"]
  ];
  final List<List<String>> nearby = [
    [
      "lib/pics/chilkurbalaji.jpg",
      "Chilkur Balaji Temple",
      "Hyderabad",
      "2 km"
    ],
    [
      "lib/pics/gnanasaraswati.jpg",
      "Gnana Saraswati Temple",
      "Basar Telangana",
      "25 km"
    ],
    [
      "lib/pics/karmanghat.jpg",
      "Karmanghat Temple",
      "Karmanghat Telangana",
      "15 km"
    ],
    [
      "lib/pics/sanghitemple.jpg",
      "Sanghi Temple",
      "Omerkhan daira Telangana",
      "10 km"
    ],
    [
      "lib/pics/surendrapuri.jpg",
      "Surendrapuri Temple",
      "Masaipet Telangana",
      "5 km"
    ],
    [
      "lib/pics/birlamandir.jpg",
      "Birla Mandir",
      "Khairtabad Telanagana",
      "15 km"
    ],
  ];
  int currentindex = 0;

  late String lat;
  late String long;

  String loc = "Hyderabad Telangana";
  //

  Future<void> convertlattoaddress(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemark[0];
    loc = '${place.locality} ${place.country}';
    setState(() {});
  }

  //

  Future<Position> _getcurrentlocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController carouselController = CarouselController();
    return Scaffold(
        drawer: Drawer(),
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.orange[600],
          title: const Text(
            "Templeguide.com",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          actions: const [
            Icon(
              Icons.alarm,
              color: Colors.black,
              size: 25,
            ),
            Icon(
              Icons.notifications,
              color: Colors.black,
              size: 25,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            Position position = await _getcurrentlocation();
                            convertlattoaddress(position);
                          },
                          icon: const Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        loc,
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CarouselSlider(
                          items: images
                              .map((item) => ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Image.asset(
                                      item,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentindex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Temples Nearby You",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),

                //

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height / 9,
                  child: ListView.separated(
                    itemCount: nearby.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsetsDirectional.only(
                              top: 15, bottom: 15),
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(219, 250, 250, 250)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Image.asset(
                                  nearby[index][0],
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width / 6,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  Text(
                                    nearby[index][1],
                                    style: GoogleFonts.varela(
                                      color:
                                          const Color.fromARGB(255, 127, 9, 7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        nearby[index][2],
                                        style: GoogleFonts.arimo(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  const SizedBox(
                                    height: 150,
                                    width: 70,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 40,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        nearby[index][3],
                                        style: GoogleFonts.gabriela(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ));
                    },
                  ),
                ),

                //
                const SizedBox(
                  height: 50,
                ),

                //
                //

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromARGB(255, 127, 9, 7),
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1.05,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Stotras",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ))
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width / 1.05,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            CardHolder(imageloc: st[0][0], name: st[0][1]),
                            CardHolder(imageloc: st[1][0], name: st[1][1]),
                            CardHolder(imageloc: st[2][0], name: st[2][1]),
                            CardHolder(imageloc: st[3][0], name: st[3][1]),

                            //
                          ]),
                        ),
                      )
                      //
                    ],
                  ),
                ),

                //

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "News & Events",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),

                //

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height / 9,
                  child: ListView.separated(
                    itemCount: nearby.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsetsDirectional.only(
                              top: 15, bottom: 15),
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(219, 250, 250, 250)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Image.asset(
                                  events[index][0],
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width / 6,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  Text(
                                    events[index][1],
                                    style: GoogleFonts.varela(
                                      color:
                                          const Color.fromARGB(255, 127, 9, 7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //
                                ],
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  const SizedBox(
                                    height: 150,
                                    width: 70,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 127, 9, 7),
                                          width: 2,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.share,
                                        color: Color.fromARGB(255, 127, 9, 7),
                                      )),
                                ],
                              )
                            ],
                          ));
                    },
                  ),
                ),

                //
              ],
            ),
          ),
        ));
  }
}
