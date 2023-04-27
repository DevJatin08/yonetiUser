import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class PostPopUp extends StatelessWidget {
  bool showedit;
  bool showdelete;
  double height;
  String? link;
  PostPopUp(
      {Key? key,
      this.height = 150,
      this.showedit = true,
      this.link,
      this.showdelete = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.7,
        child: Material(
          child: Container(
            width: size.width * 0.7,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[100],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      showedit
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      showedit
                          ? Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      showdelete
                          ? SizedBox(
                              height: 20,
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      showdelete
                          ? Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Share.share('${link}');
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Share to..",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: "${link}"));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Copy link",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
