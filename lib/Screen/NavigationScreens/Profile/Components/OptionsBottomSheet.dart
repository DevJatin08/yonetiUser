import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/AuthScreens/LoginScreen.dart';
import 'package:userapp/Screen/CommonWidgets/Popup.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Schedule.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/StarFilter.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Template.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/AboutYoneti.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/AccountSetting.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/ChangePassword.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/FeedbackSupport.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/MyReview.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/PaymentHistory.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/PaymentgateWay.dart';

class OptionsBottomSheet extends HookWidget {
  const OptionsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = useProvider(userInfoProvider);
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  print('sd');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20),
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(color: Color(0xff9d9d9d), borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SingleOption(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileTemplate(
                          widget: PaymentGateWay(),
                          name: 'Payment',
                          appBarButton: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProfileTemplate(
                                      widget: PaymentHistory(),
                                      name: 'Payment History',
                                      extraImage: false,
                                      appBarButton: IconButton(
                                        icon: Icon(Icons.filter_alt),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: false,
                                              context: context,
                                              builder: (context) {
                                                return Schedule();
                                              });
                                        },
                                      ),
                                      top: Colors.white,
                                      bottom: Color(0xff454545),
                                      // bottom: Colors.white,
                                      // top: primaryColor,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Color(0xff454545), borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                child: Text(
                                  'History',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          url: 'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                          extraImage: true,
                        );
                      },
                    ),
                  );
                },
                icon: Icons.payment_outlined,
                title: "Manage Payments",
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileTemplate(
                          widget: AccountAndSettings(),
                          name: 'Account and settings',
                          extraImage: false,
                        );
                      },
                    ),
                  );
                },
                icon: Icons.settings_outlined,
                title: "Account & settings",
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                  onTap: () {
                    customPopUp(context, ChangePassword());
                  },
                  icon: Icons.lock_outlined,
                  title: "Change Password"),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileTemplate(
                            widget: FeedbackSupport(),
                            name: 'Feedback & Support',
                            extraImage: false,
                            top: Colors.white,
                            bottom: Color(0xff454545),
                          );
                        },
                      ),
                    );
                  },
                  icon: Icons.comment_outlined,
                  title: "Feedback & Support"),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileTemplate(
                            widget: AboutYoneti(),
                            name: 'About Yoneti',
                            extraImage: false,
                            top: Colors.white,
                            bottom: Color(0xff454545),
                          );
                        },
                      ),
                    );
                  },
                  icon: Icons.info_outlined,
                  title: "About Yoneti"),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileTemplate(
                            widget: MyReviews(),
                            appBarButton: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.star_rate),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: false,
                                        context: context,
                                        builder: (context) {
                                          return StarFilter();
                                        });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.filter_alt),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: false,
                                        context: context,
                                        builder: (context) {
                                          return Schedule();
                                        });
                                  },
                                ),
                              ],
                            ),
                            name: 'My Reviews',
                            extraImage: false,
                            top: Colors.white,
                            bottom: primaryColor,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icons.reviews_outlined,
                  title: "My Reviews"),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
                height: 0,
              ),
              SingleOption(
                icon: Icons.logout_outlined,
                title: "Sign Out",
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                  userProvider.signOut();
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        // height: size.height * .5,
      ),
    );
  }
}

class SingleOption extends StatelessWidget {
  final String title;
  final Function? onTap;
  final IconData icon;
  const SingleOption({required this.icon, required this.title, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Row()
    return ListTile(
      onTap: onTap as void Function()?,
      visualDensity: VisualDensity(horizontal: -4, vertical: -1),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      horizontalTitleGap: 10,
      title: Text(
        title,
        style: TextStyle(color: thirdColor, fontFamily: 'bold', letterSpacing: .8, fontSize: 14),
      ),
      leading: Icon(icon),
      trailing: Icon(Icons.chevron_right_outlined),
    );
  }
}
