import 'package:flutter/material.dart';
import 'package:portfolio_app/models/project.dart';
import 'package:portfolio_app/pages/project/video_demo.dart';
import 'package:portfolio_app/pages/project/video_screen.dart';
import 'package:portfolio_app/responsive.dart';

class ProjectDetail extends StatelessWidget {
  final Project project;
  const ProjectDetail({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BackButton(
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          project.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15.0)),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            project.year.toString(),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Hero(
                        tag: project.name,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Responsive(
                            mobile: Image.network(
                              project.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            tablet: Image.network(
                              project.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            desktop: SizedBox(
                              height: 350,
                              child: Image.network(
                                project.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Technologies",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          HorizontalTechView(
                            techList: project.technologiesUsed ?? [],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            project.description,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        // send it the video from the model
                                        builder: (_) => VideoApp()
                                    )
                                );
                              },
                              child: Text("See Video")),
                          const Text(
                            "App Images",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          project.appImages != []
                              ? appImages(project.appImages)
                              : Container()
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalTechView extends StatelessWidget {
  final List<String> techList;
  const HorizontalTechView({required this.techList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: techList.length,
        itemBuilder: (context, index) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              child: Text(techList[index],
                  style: const TextStyle(color: Colors.black)));
        },
      ),
    );
  }
}

Widget appImages(List<String>? imgList) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: imgList!.length,
      itemBuilder: (context, index) {
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 15.0, left: 15.0),
            margin: const EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: Image.network(
              imgList[index],
              fit: BoxFit.cover,
            ));
      });
}
