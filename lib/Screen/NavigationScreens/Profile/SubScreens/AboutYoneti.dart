import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/AboutYoneti/AboutYoneti.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class AboutYoneti extends StatefulHookWidget {
  @override
  _AboutYonetiState createState() => _AboutYonetiState();
}

class _AboutYonetiState extends State<AboutYoneti> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _aboutyonetiProvider = useProvider(AboutyonetiProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
      child: FutureBuilder<AboutYonetis>(
        future: _aboutyonetiProvider.getAboutYoneti(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      data!.websiteAddress.isEmpty
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Website Found")))
                          : launch("https://${data.websiteAddress}/");
                    },
                    child: Text(
                      "Visit our Website",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'semiBold',
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                    height: 0,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.symmetric(vertical: 10),
                    title: Text(
                      "Terms of Services",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontFamily: 'semiBold',
                      ),
                    ),
                    children: [
                      Text(
                        "${data!.termsOfServices}",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontFamily: 'medium',
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                    height: 0,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.symmetric(vertical: 10),
                    title: Text(
                      "Privacy & Policy",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontFamily: 'semiBold',
                      ),
                    ),
                    children: [
                      Text(
                        "${data.privacyPolicy}",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontFamily: 'medium',
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                    height: 0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "License: ${data.license}",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'semiBold',
                    ),
                  ),
                ],
              ),
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
