import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_move/models/activities.dart';
import 'package:we_move/providers/activities_provider.dart';

import '../models/activities_card.dart';

class ActivitiesScreenDetails extends StatefulWidget {
  const ActivitiesScreenDetails({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreenDetails> createState() =>
      _ActivitiesScreenDetailsState();
}

class _ActivitiesScreenDetailsState extends State<ActivitiesScreenDetails>
    with TickerProviderStateMixin {
  late TabController _tabcontroller;
  List<ActivitiesCard>? _activitiesByType;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ActivitiesProvider>(context, listen: false)
          .getAllActivities();
    });
  }

  List<ActivitiesCard> getActivitiesByType(
      List<dynamic> listActivities, String type) {
    List<ActivitiesCard> activities = [];

    listActivities.forEach((element1) {
      element1.activityTypes!.forEach((element) {
        if (element.label!.contains(type)) {
          activities.add(ActivitiesCard(
              image: element1.image1,
              name: element1.name,
              description: element1.description));
        }
      });
    });
    return activities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff141d41),
        body: Consumer<ActivitiesProvider>(
          builder: (context, value, child) {
            // If the loading it true then it will show the circular progressbar
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            final activities = value.activities;
            final activitiesTypes = value.activitiesTypes;

            // If loading is false and list of activities is empty then this code will show a message with button to reload data
            _activitiesByType =
                getActivitiesByType(activities, activitiesTypes[0]);

            if (value.activities.isEmpty) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Oups, WeMove n'a pas encore bougé dans ce sens",
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                          child: const Text("Load Data"),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ActivitiesScreenDetails()),
                            );
                          }),
                    ]),
              );
            }
            // else this code will show the list of activities
            else {
              _tabcontroller =
                  TabController(length: activitiesTypes.length, vsync: this);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                  // Custom TabBar
                  Container(
                    height: 100,
                    child: TabBar(
                        controller: _tabcontroller,
                        indicatorWeight: 0.1,
                        isScrollable: true,
                        onTap: (value) => setState(() {
                              _activitiesByType = getActivitiesByType(
                                  activities, activitiesTypes[value]);
                            }),
                        tabs: List.generate(
                            activitiesTypes.length,
                            (index) => Card(
                                  color: Color(0x00000000),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      activitiesTypes[index],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                        itemCount: _activitiesByType!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Ink.image(
                                  image: const NetworkImage(
                                    //  'https://test.backend.wemove.tn/api/v1/client-panel' + _activitiesByType![index].image!,
                                    'https://avogel.fr/blog/wp-content/uploads/2017/02/dopamine-sport-1580x770.jpg',
                                  ),
                                  height: 240,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _activitiesByType![index].name!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        _activitiesByType![index].description!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ))
                ],
              );
            }
          },
        ));
  }
}
