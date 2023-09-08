import 'package:cube_slider/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MaterialApp(home: Cube_Slider()));
}

class Cube_Slider extends StatefulWidget {
  const Cube_Slider({super.key});

  @override
  State<Cube_Slider> createState() => _Cube_SliderState();
}

class _Cube_SliderState extends State<Cube_Slider> {
  Dio dio = Dio();

  Future<List<Post>> getData() async {
    var response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return listFromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[500],
      body: CarouselSlider(
          slideTransform: CubeTransform(),
          slideIndicator:
              CircularSlideIndicator(padding: EdgeInsets.only(bottom: 10)),
          unlimitedMode: true,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => ListTile(
                            leading: Text("${snapshot.data![index].userId}"),
                            title: Text("${snapshot.data![index].body}"),
                            subtitle: Text("${snapshot.data![index].id}"),
                            trailing: Text("${snapshot.data![index].title}"),
                          ));
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.red));
                }
              },
            ),
            Container(color: Colors.red),
            Container(color: Colors.yellow),
          ]),
    );
  }
}
