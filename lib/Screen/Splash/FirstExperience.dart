import 'package:flutter/material.dart';
import 'package:userapp/Constant/BackgroundDecoration.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Screen/AuthScreens/LoginScreen.dart';

class FirstTimeExperienceScreen extends StatefulWidget {
  FirstTimeExperienceScreen({Key? key}) : super(key: key);

  @override
  _FirstTimeExperienceScreenState createState() => _FirstTimeExperienceScreenState();
}

class _FirstTimeExperienceScreenState extends State<FirstTimeExperienceScreen> {
  PageController pageController = PageController(initialPage: 0);
  int selectedPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // pageController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Container(
        decoration: splashDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (a) {
                    setState(() {
                      selectedPage = a;
                    });
                  },
                  children: [
                    FirstTimeExperienceContent(
                      titleText: 'Quick Search',
                      subtitleText: ' locar location to start exploring restaurants around you',
                      imageUrl: 'assets/Splash/rocket.png',
                    ),
                    FirstTimeExperienceContent(
                      titleText: 'Search for a place',
                      subtitleText:
                          'Set your location to start exploring & Booking services around you',
                      imageUrl: 'assets/Splash/flag.png',
                    ),
                    FirstTimeExperienceContent(
                      titleText: 'Schedule your service',
                      subtitleText:
                          'Set your location to start hiring & scheduling services around you',
                      imageUrl: 'assets/Splash/calendar.png',
                    ),
                    FirstTimeExperienceContent(
                      titleText: 'Quick acess & alerts',
                      subtitleText:
                          'Book or hire any service today so you dont need to wait for your turn',
                      imageUrl: 'assets/Splash/access.png',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  if (selectedPage < 3) {
                    pageController.jumpToPage(selectedPage + 1);

                    setState(() {});
                  } else {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  }
                },
                child: Container(
                  width: size.width,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: selectedPage == 3 ? 14 : 10),
                    child: selectedPage == 3
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(color: Color(0xff3a5cb1)),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(color: Color(0xff3a5cb1)),
                              ),
                              Icon(Icons.chevron_right, color: Color(0xff3a5cb1))
                            ],
                          ),
                  ),
                ),
              ),
            ),
            Container(
              width: 72,
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: index != selectedPage.toInt() ? Colors.white : Colors.grey,
                            shape: BoxShape.circle),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class FirstTimeExperienceContent extends StatelessWidget {
  String titleText;
  String subtitleText;
  String imageUrl;
  FirstTimeExperienceContent(
      {required this.titleText, required this.subtitleText, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          imageUrl,
          width: size.width * 0.5,
          height: size.width * 0.5,
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          width: size.width * 0.7,
          child: Column(
            children: [
              Text(
                titleText,
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                subtitleText,
                overflow: TextOverflow.clip,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, wordSpacing: 2),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
      ],
    );
  }
}
