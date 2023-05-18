import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';

class FeedbackSupport extends ConsumerStatefulWidget {
  @override
  _FeedbackSupportState createState() => _FeedbackSupportState();
}

class _FeedbackSupportState extends ConsumerState<FeedbackSupport> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController feedbackController = TextEditingController();
  String feedback = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _feedbackProvider = ref.watch(feedbackProvider);

    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Like us on Facebook",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.white,
                  height: 0,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.instagramSquare,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Follow us on Instagram",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.white,
                  height: 0,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.googlePlay,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "rate us on Google Play Store",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.white,
                  height: 0,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Leave a Feedback",
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: 'bold',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: size.height * 0.18,
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: feedbackController,
                      // initialValue:'Let us know what you think how we can improve, or tell us if you’re facing anyissues to improve user experiece.',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedErrorBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        errorBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        hintText:
                            'Let us know what you think how we can improve, or tell us if you’re facing anyissues to improve user experiece.',
                      ),
                      // decoration: transparentInputDecoration,
                      validator: (val) {
                        if (val == "" || val == " ") {
                          return "Enter Feedback";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          feedback = val!;
                        });
                      },
                      maxLines: 5,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 11,
                        color: Color(0xff9d9d9d),
                        fontFamily: 'bold',
                      ),
                    )
                    //  Text(
                    //   "Let us know what you think how we can\nimprove, or tell us if you'r facing any\nissues to improve user experience.",
                    //   style: TextStyle(
                    //     letterSpacing: 0.5,
                    //     fontSize: 11,
                    //     color: Color(0xff9d9d9d),
                    //     fontFamily: 'bold',
                    //   ),
                    // ),
                    ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    textColor: Color(0xff9d9d9d),
                    text: 'Submit',
                    family: 'semiBold',
                    voidCallback: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        _feedbackProvider.getFeedback(feedback: feedback);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Feedback send successfully")));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Thanks for your feedback")));
                        setState(() {
                          feedbackController.clear();
                        });
                      }
                      setState(() {});
                    },
                    color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
