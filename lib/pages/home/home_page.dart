import 'package:flutter/material.dart';
import 'package:portfolio_app/example/projects.dart';
import 'package:portfolio_app/responsive.dart';
import 'package:portfolio_app/widgets/Cards/project_card.dart';
import 'package:portfolio_app/widgets/header/header.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.share,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            Share.share("Check out Matt's Flutter Portfolio https://my-portfolio-c3ae5.firebaseapp.com");
          }),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Projects",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Responsive(
                      mobile: mobileTabletBuilder(350),
                      tablet: mobileTabletBuilder(450),
                      desktop: desktopBuilder()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileTabletBuilder(double height) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }

  Widget desktopBuilder() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        });
  }
}
