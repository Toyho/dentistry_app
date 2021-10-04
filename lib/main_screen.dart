// ignore_for_file: prefer_const_constructors
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  static final LatLng _kMapCenter = LatLng(52.980137, 36.071302);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 110,
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [ColorsRes.fromHex(ColorsRes.primaryColor), Colors.white],),
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).primaryColor,
                                    blurRadius: 7,
                                    offset: Offset(0, 8))
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                                child: Text("Заголовок", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image.asset(ImageRes.toothbrush, fit: BoxFit.fill, width: 200,)),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            height: 220,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FutureBuilder(
                        future: generateMarkers([_kMapCenter]),
                        builder: (BuildContext context,
                            AsyncSnapshot<Set<Marker>> snapshot) {
                          Widget child;
                          if (snapshot.hasData) {
                            child = GoogleMap(
                              initialCameraPosition: _kInitialPosition,
                              markers: snapshot.data!,
                            );
                          } else {
                            child = Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 20,
                                height: 20,
                              ),
                            );
                          }
                          return child;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 12),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Город Орёл, улица 60-летия Октября, 15",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
    List<Marker> markers = <Marker>[];
    for (final location in positions) {
      final Uint8List icon = await getBytesFromAsset(ImageRes.pinImage, 100);

      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude, location.longitude),
        icon: BitmapDescriptor.fromBytes(icon),
      );

      markers.add(marker);
    }

    return markers.toSet();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
